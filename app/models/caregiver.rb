# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  zipcode                :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  gender                 :integer
#  bio                    :text(65535)
#  headline               :string(255)
#  hours                  :string(255)      default("0")
#  work_experience        :integer
#  availability           :integer
#  insured                :boolean
#  bonded                 :boolean
#  background_checked     :boolean
#  reviewed               :boolean
#  latitude               :float(24)
#  longitude              :float(24)
#  city                   :string(255)
#  state                  :string(255)
#  hourly_rate            :integer
#  references_count       :integer          default(0)
#  private                :boolean
#  facebook_id            :string(255)
#  type                   :string(255)      default("User")
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  phone                  :string(255)
#  transportation         :integer
#  date_of_birth          :date
#  employer               :string(255)
#  pets                   :integer
#  avatar_processing      :boolean
#  hospice                :boolean          default(FALSE)
#  indexable              :boolean          default(FALSE)
#  smokes                 :integer
#  md5hash                :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  customer_id            :string(255)
#  contacted              :boolean          default(FALSE)
#  carrier                :string(255)
#  question_1             :text(65535)
#  question_2             :text(65535)
#  question_3             :text(65535)
#  question_4             :text(65535)
#  background             :string(255)
#  live_in                :boolean
#  hometown               :text(65535)
#  live_in_rate           :integer
#  edit_profile_modal     :boolean          default(FALSE)
#  congrats_modal         :boolean          default(FALSE)
#  referral_code          :string(255)
#

require_dependency 'area'

class Caregiver < User
  include Tire::Model::Search

  has_many :references
  has_many :offers
  has_one :cover_letter

  has_and_belongs_to_many :contracts

  after_create :send_greeting_email
  after_create :create_cover_letter
  after_save :update_index
  after_save :update_mailchimp

  before_save :calculate_location

  geocoded_by :zipcode
  after_validation :geocode
  scope :completed, -> { where("gender IS NOT NULL AND hourly_rate IS NOT NULL AND bio IS NOT NULL AND work_experience IS NOT NULL AND zipcode IS NOT NULL AND contacted IS FALSE") }

  GENERAL = [
    {:key => :pets, :value => 'Comfortable with Pets'},
    {:key => :no_allergies, :value => 'No Allergies'},
    {:key => :non_smoker, :value => 'Non Smoker'},
    {:key => :has_hospice, :value => 'Works with Hospice Patients'},
  ]

  validates :smokes, inclusion: { in: [1,2,3] }, allow_blank: true
  # validates_length_of :question_1, minimum: 100, too_short: 'Your answer must be at least 100 words.',
  #                     tokenizer: ->(str) { str.scan(/\w+/) }

  BACKGROUNDS =[
    'nature.jpg',
    'bokeh.jpg',
    'dock.jpg',
    'ocean.jpg',
    'forest.jpg',
    'field.jpg'
  ]

  def plucked_health_service_ids
    @plucked_health_service_ids ||= self.health_services.pluck(:id)
  end

  def plucked_general_service_ids
    @plucked_health_service_ids ||= self.general_services.pluck(:id)
  end

  def plucked_technical_service_ids
    @plucked_technical_service_ids ||= self.technical_services.pluck(:id)
  end

  def plucked_skill_service_ids
    @plucked_skill_service_ids ||= self.skill_services.pluck(:id)
  end

  def background_path
    if background
        'backgrounds/' + background
    else
        ''
    end
  end

  def self.get_averages caregivers
    count = caregivers.count

    if count == 0 || count > 10
      count = count
      work_experience = 0
      age = 0
      hourly_rate = 0
    else
      count = count + 1
      work_experience = 5
      age = 25
      hourly_rate = 11
    end

    caregivers.each do |c|
      work_experience += c.work_experience.to_i
      age += c.age.to_i
      hourly_rate += c.hourly_rate.to_i
    end

    if count == 0
      OpenStruct.new(work_experience: count, age: count, hourly_rate: count)
    else
      OpenStruct.new(work_experience: work_experience / count, age: age / count, hourly_rate: hourly_rate / count)
    end
  end

  def lat_lng
    [latitude, longitude].join(',')
  end

  def update_index
    if indexable
      tire.update_index
    end
  end

  def update_mailchimp
    if self.date_of_birth_changed? || self.first_name_changed? || self.last_name_changed? || self.zipcode_changed? || self.phone_changed?
      UpdateCaregiverInMailchimpJob.set(wait: 10.minutes).perform_later(self)
    end
  end

  def has_hours?
    hours != '0' && !hours.nil?
  end

  def has_saftey_verifications?
    facebook_id # or anything else in the future
  end

  def has_facebook?
    facebook_id
  end

  def should_show_badge?
    has_hours? && hours.to_i >= 20
  end

  def update_index_if_able
    update_index
  end

  tire do
   mapping do
    indexes :id,   type: 'string', analyzer: 'snowball'
    indexes :lat_lng, type: 'geo_point', lat_lon: true

    indexes :gender, type: 'integer'
    indexes :transportation, type: 'integer'
    indexes :hourly_rate, type: 'integer'
    indexes :live_in_rate, type: 'integer'
    indexes :work_experience, type: 'integer'
    indexes :availability, type: 'integer'
    indexes :headline, type: 'string', analyzer: 'snowball'
    indexes :bio, type: 'string', analyzer: 'snowball'
    indexes :full_name, type: 'string', analyzer: 'keyword'
    indexes :languages, type: 'string', analyzer: 'keyword'
    indexes :services, type: 'string', analyzer: 'keyword'
    indexes :schools, type: 'string', analyzer: 'keyword'
    indexes :is_RN, type: 'boolean'
    indexes :is_LVN, type: 'boolean'
    indexes :is_CNA, type: 'boolean'
    indexes :is_HHA, type: 'boolean'
    indexes :is_smoker, type: 'boolean'
    indexes :has_allergies, type: 'boolean'
    indexes :testimonials, type: 'integer'
    indexes :carespotter_hours, type: 'integer'
    indexes :degree, type: 'boolean'
    indexes :has_hospice, type: 'boolean'
    indexes :likes_pets, type: 'boolean'
    indexes :updated_at, type: 'date', show: :not_analyzed
    indexes :live_in, type: 'boolean'
    indexes :hometown, type: 'string'
   end
  end

  def to_indexed_json
   {
       :id => self.id,
       :lat_lng => self.lat_lng,
       :email => self.email,
       :bio => self.bio,
       :gender => self.gender,
       :transportation => (self.transportation == User::Transportation::YES[:value] || self.transportation == User::Transportation::SOMETIMES[:value]) ?
                            User::Transportation::YES[:value] : User::Transportation::NO[:value],
       :hourly_rate => self.hourly_rate,
       :live_in_rate => self.live_in_rate,
       :work_experience => self.work_experience,
       :availability => self.availability,
       :headline => self.headline,
       :full_name => self.full_name,
       :languages => self.language_ids,
       :services => self.services_to_codes,
       :schools => self.school_names,
       :is_RN => self.RN?,
       :is_LVN => self.LVN?,
       :is_CNA => self.CNA?,
       :is_HHA => self.HHA?,
       :non_smoker => !self.smoker?,
       :no_allergies => !self.allergies?,
       :references => self.references_count,
       :carespotter_hours => self.hours,
       :degree => self.college_graduate?,
       :has_hospice => self.hospice,
       :likes_pets => self.likes_pets?,
       :updated_at => self.updated_at,
       :live_in => self.live_in,
       :hometown => self.hometown
   }.to_json
  end

  def services_to_codes
    services.map { |s| s.id }
  end

  def school_names
    schools.map { |s| s.name }
  end

  def RN?
    credential && credential.RN?
  end

  def LVN?
    credential && credential.LVN?
  end

  def CNA?
    credential && credential.CNA?
  end

  def HHA?
    credential && credential.HHA?
  end

  def CPR?
    credential && credential.CPR?
  end

  def smoker?
    smokes == 1 || smokes == 2
  end

  def allergies?
    allergies.length > 0
  end

  def build_resources klass
    resources = self.send(klass.name.downcase.pluralize)

    (5 - resources.size).times do
      resources << klass.new(user_id: id)
    end

    resources
  end

  def highest_education_by_degree
    schools.order(:degree).limit(1)[0]
  end

  def college_graduate?
    !highest_education_by_degree.nil? && !highest_education_by_degree.degree.nil? && highest_education_by_degree.degree != 4
  end

  def likes_pets?
    pets == 1 || pets == 5
  end

  def references_list page
    Reference.where(caregiver_id: id).page(page || 1).per(3)
  end

  def has_references?
    references_count.zero? ? false : true
  end

  def active_contracts
    contracts
  end

  def contract_ids
    contracts.pluck(:id)
  end

  def contract_ids_from_offers
    offers.pluck(:contract_id)
  end

  def applied_for_contract? contract
    if contract_ids_from_offers.include? contract.id
      offer = offer_for_contract(contract)
      if offer
        return !offer.declined?
      else
        false
      end
    else
      false
    end
  end

  def offer_for_contract contract
    Offer.where(contract_id: contract.id, caregiver_id: id).first
  end

  def completed_profile?
    !!(self.gender && self.hourly_rate && self.question_1 && self.work_experience && self.zipcode && self.background && self.has_avatar?)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ['ID', 'First Name', 'Last Name', 'Email', 'Phone', 'Facebook ID', 'Created At', 'Has Avatar', 'References']
      order('created_at DESC').each do |caregiver|
        values = []

        values << caregiver.id
        values << caregiver.first_name
        values << caregiver.last_name
        values << caregiver.email
        values << caregiver.phone
        values << caregiver.facebook_id
        values << caregiver.created_at
        values << caregiver.has_avatar?
        values << caregiver.references_count

        csv << values
      end
    end
  end

  def to_hash
    {
      id: self.id,
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email,
      phone: self.phone,
      gender: self.gender,
      date_of_birth_day: self.date_of_birth_day,
      date_of_birth_month: self.date_of_birth_month,
      date_of_birth_year: self.date_of_birth_year,
      date_of_birth: self.date_of_birth,
      zipcode: self.zipcode,
      language_ids: self.language_ids,
      transportation: self.transportation,
      pets: self.pets,
      smokes: self.smokes,
      allergy_ids: self.allergy_ids,
      bio: self.bio,
      headline: self.headline,
      work_experience: self.work_experience,
      hourly_rate: self.hourly_rate,
      live_in_rate: self.live_in_rate,
      availability: self.availability,
      technical_service_ids: self.technical_services.pluck(:id),
      general_service_ids: self.general_services.pluck(:id),
      health_service_ids: self.health_services.pluck(:id),
      skill_service_ids: self.skill_services.pluck(:id),
      live_in: self.live_in,
      hometown: self.hometown
    }
  end

  def calculate_location
    if !self.zipcode.blank?

      zip = zipcode.to_s

      latlon = zip.to_latlon.split(",")
      region = zip.to_region.gsub(" ", "").split(",")

      self.latitude = latlon[0]
      self.longitude = latlon[1]
      self.city = region[0]
      self.state = region[1]
    end
  end

  def send_approval_email
    CaregiverMailer.send_approval_email(self).deliver_later(wait: 5.seconds)
  end

  def active_schedule
    Schedule.by_caregiver_id(self.id)
  end

  private

  def send_greeting_email
    CaregiverMailer.send_greeting_email(self).deliver_later(wait: 5.seconds)
  end

  def create_cover_letter
    if self.cover_letter.nil?
      CoverLetter.create!(caregiver_id: self.id)
    end
  end

  def send_interview_guide_email
    # noop
  end
end
