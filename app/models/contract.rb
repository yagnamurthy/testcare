# == Schema Information
#
# Table name: contracts
#
#  id              :integer          not null, primary key
#  owner_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  headline        :string(255)
#  description     :text(65535)
#  hours_needed    :integer
#  job_type        :integer
#  required_rate   :integer
#  latitude        :float(24)
#  longitude       :float(24)
#  zipcode         :string(255)
#  city            :string(255)
#  state           :string(255)
#  patient_name    :string(255)
#  phone           :string(255)
#  indexable       :boolean          default(FALSE)
#  schedule_type   :integer
#  schedule_need   :boolean
#  gender          :integer
#  age_range       :integer
#  hourly_type     :string(255)
#  has_been_edited :boolean          default(FALSE)
#  care_type       :integer
#  expected_date   :date
#  days_of_care    :integer
#  time_of_care    :integer
#  language        :integer
#

require_dependency "zip_code_converter"

class Contract < ActiveRecord::Base

  has_and_belongs_to_many :services
  has_and_belongs_to_many :requirements
  has_and_belongs_to_many :caregivers
  has_and_belongs_to_many :care_types

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :journals
  has_many :contacts
  has_many :offers
  has_many :messages
  has_many :screening_questions
  has_many :schedules

  include Tire::Model::Search

  tire do
    mapping do
        indexes :id,   type: 'string', analyzer: 'snowball'
        indexes :lat_lng, type: 'geo_point'
        indexes :created_at, type: 'date'
        indexes :updated_at, type: 'date'
     end
  end

  #validates :hours_needed, inclusion: { in: 1..4 }

  # validates :headline, presence: true
  # validates :description, presence: true
  #validates :description, length: { minimum: 100 }

  #validates_format_of :zipcode, with: /\A\d{5}$\z/, message: 'must have a valid zipcode'
  #validates_format_of :phone, with: /\A(\d{10}|\d{3}-a\d{3}-\d{4})\z/, message: 'must have a valid phone number'


  #before_validation :format_phone
  #before_validation :format_zipcode

  #before_save :calculate_location
  after_save :update_index
  #after_save :send_email_about_updated_unapproved_job

  attr_accessor :general_services_attributes, :health_services_attributes

  HOURLY = { label: 'Hourly', value:1 }
  LIVEIN = { label: 'Live in', value:2 }

  HOUR_OPTIONS = [
    ["5 to 10", 1],
    ["10 to 20", 2],
    ["20 to 40", 3],
    ["Live In", 4]
  ]

  SCHEDULE_TYPE = [
    {label: 'Occasional', value: 1},
    {label: 'Regular Scheduled', value: 2},
    {label: 'One Time', value: 3}
  ]

  SCHEDULE_NEED = [
      {label: 'Yes', value: 1},
      {label: 'No', value: 0}
  ]

  CARE_TYPE = [
    {label: 'Home Care', value: 1},
    {label: 'Respite Care', value: 2},
    {label: 'Transportation Services', value: 3}
  ]

  AGE_RANGE = [
      ['Under 55 years old', 0],
      ['55 to 64 years old', 1],
      ['65 to 74 years old', 2],
      ['75 to 84 years old', 3],
      ['Over 85 years old', 4]
  ]

  def to_indexed_json
    {
      :id => self.id,
      :lat_lng => self.lat_lng,
      :created_at => self.created_at,
      :updated_at => self.updated_at

    }.to_json
  end

  def lat_lng
    [latitude, longitude].join(',')
  end

  def self.search_by_lat_lng search_query
    result = Geocoder.search(search_query).first

    search load:true do
      sort { by :updated_at, 'desc' }
      filter :geo_distance, { lat_lng: [result.latitude, result.longitude].join(','), distance: "25mi" }
    end
  end

  def self.hour_options
    HOUR_OPTIONS
  end

  def schedule_to_label
    [HOURLY, LIVEIN].each do |type|
      if type[:value] == self.job_type
        return type[:label]
      end
    end
  end

  def hours_needed_schedule
    if self.hours_needed == 1 || self.hours_needed == 2
      'Part Time'
    elsif self.hours_needed == 3
      'Full Time'
    else
      'Live In'
    end
  end

  def format_phone
    self.send("phone=", self.phone.to_s.gsub(/-/, '')) if self.phone
  end

  def format_zipcode
    self.send("zipcode=", self.zipcode.to_s.squish) if self.zipcode
  end

  def calculate_location
    if !self.zipcode.blank?
      converter = Geocoder.search(self.zipcode).first
      self.latitude = converter.latitude
      self.longitude = converter.longitude
      self.state = converter.state
      self.city = converter.city
    end
  end

  def assign_services services
    services = Services.where(id: services)
  end

  def has_services?
    services.length > 0
  end

  def has_requirements?
    requirements.length > 0
  end

  def self.get_based_on_message message
    offer = Offer.where(conversation_id: message.id).first

    if offer
      offer.contract
    else
      nil
    end
  end

  def offers_newly_created_count
    Offer.where(contract_id: id).newly_created.count
  end

  def participants
    participants = []
    self.caregivers.map { |u| participants << u }
    participants << self.owner
    participants
  end

  def update_index
    if indexable
      tire.update_index
    end
  end

  def send_email_about_updated_unapproved_job
    ContractMailer.send_new_job.deliver_later(wait: 5.seconds) unless indexable
  end

  def send_email_to_caregivers
    @search_engine = Caregiver::Search.new({miles: 30, zipcode: self.zipcode, per_page: 10000})
    caregivers = @search_engine.search

    caregivers.each do |caregiver|
      ContractMailer.send_new_jobs_in_your_area(caregiver, self).deliver_later(wait: 5.seconds)

      if caregiver.phone && caregiver.carrier
        self.send_text_message(caregiver)
      end
    end

    caregivers.to_a.shuffle.first(30).each do |caregiver|
      CaregiverMailer.send_family_is_checking_you_out(caregiver, self).deliver_later(wait: 5.hours)
    end
  end

  def send_text_message caregiver
    TextMessageJob.perform_later(caregiver)
  end

  def time_of_cares
    if self.time_of_care == 0
      'Morning'
    elsif self.time_of_care == 1
      'Afternoon'
    elsif self.time_of_care == 2
      'Evening'
    else
      'Overnight'
    end
  end
end
