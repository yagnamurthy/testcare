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

class User < ActiveRecord::Base
  include User::Gender
  include Sprockets::Rails::Helper
  extend Mailboxer::Models::Messageable::ActiveRecordExtension

  acts_as_messageable

  has_one :schedule
  has_one :credential
  has_one :question
  has_one :crop_data # this should be removed one day

  # has_one :contract, :through => :current_contract
  has_one :current_contract, foreign_key: 'owner_id', class_name: 'Contract'
  has_one :job, :through => :current_contract

  has_many :references
  has_many :schools
  has_many :experiences
  has_many :trainings
  has_many :credit_cards
  has_many :avatars


  # invoices
  has_many :invoices, through: :received_invoices
  has_many :invoices, through: :sent_invoices
  has_many :received_invoices, foreign_key: :receiver_id, class_name: 'Invoice'
  has_many :sent_invoices, foreign_key: :sender_id, class_name: 'Invoice'




  has_many :journals
  # has_many :contacts
  # has_and_belongs_to_many :contracts
  has_and_belongs_to_many :allergies
  has_and_belongs_to_many :services
  has_and_belongs_to_many :languages, :association_foreign_key => "language_code"

  has_and_belongs_to_many :health_services, association_foreign_key: "service_id"
  has_and_belongs_to_many :general_services, association_foreign_key: "service_id"
  has_and_belongs_to_many :technical_services, association_foreign_key: "service_id"
  has_and_belongs_to_many :skill_services, association_foreign_key: "service_id"

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  accepts_nested_attributes_for :schools, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :experiences, :reject_if => lambda { |a| a[:employer].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :credential

  accepts_nested_attributes_for :schedule
  accepts_nested_attributes_for :allergies
  accepts_nested_attributes_for :health_services
  accepts_nested_attributes_for :general_services
  accepts_nested_attributes_for :skill_services

  validate :validate_birth_date

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :presence => true
  validates :phone, :presence => true, unless: Proc.new { |u| u.caregiver? }

  validates :email, :presence => true
  validates_format_of :email, :with => VALID_EMAIL_REGEX

  geocoded_by :zipcode
  after_validation :geocode
  def email_regex
    if email.present? and not email.match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/)
      errors.add :email, "Valid email format is required"
    end
  end


  after_create :send_greeting_email
  after_create :send_interview_guide_email
  after_create :subscribe_to_mailchimp
  after_create :generate_referral_code
  # after_create :create_customer
  after_create :update_contract

  before_create :create_md5hash

  before_validation :format_date_of_birth
  before_update :format_phone
  before_update :format_zipcode

  before_save :format_name

  after_find    :unformat_date_of_birth

  scope :families, -> { where(type: 'User') }

  attr_accessor :services_ids, :health_services_ids, :affiliates_ids
  attr_accessor :date_of_birth_day, :date_of_birth_month, :date_of_birth_year
  attr_accessor :potential_facebook_id
  attr_accessor :contract_id


  def format_date_of_birth
    if self.date_of_birth_year && self.date_of_birth_month && self.date_of_birth_day
      self.date_of_birth = Date.new self.date_of_birth_year.to_i, self.date_of_birth_month.to_i, self.date_of_birth_day.to_i
    end
  end

  def validate_birth_date
    if date_of_birth_year.present? && !date_of_birth.present?
      errors.add :date_of_birth, "must be a valid date."
    end
  end

  def unformat_date_of_birth
    if self.date_of_birth
      self.date_of_birth_year = self.date_of_birth.year
      self.date_of_birth_month = self.date_of_birth.month
      self.date_of_birth_day = self.date_of_birth.day
    end
  end

  def caregiver?
    self.type === 'Caregiver'
  end

  def family?
    self.type == 'User'
  end

  def admin?
    self.type === 'Admin'
  end

  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    else
      "#{first_name}"
    end
  end

  def first_and_last_initial
    if first_name && last_name
      "#{first_name} #{last_name[0]}."
    else
      if first_name
        "#{first_name}"
      end
    end
  end

  def address
    "#{city}, #{state}"
  end

  def format_phone
    self.send("phone=", self.phone.to_s.gsub(/-/, '')) if self.phone
  end

  def format_zipcode
    self.send("zipcode=", self.zipcode.to_s.squish) if self.zipcode
  end

  def unread_messages
    @unread_messages ||= MailReceipt.find_by_recipient_id(id).unread
  end

  def self.calculate_age dob
    (Date.today - dob).to_i / 365
  end

  def job
    Contract.where(owner_id: id).first
  end

  def new_jobs
    Contract.where(zipcode: zipcode, created_at: 2.weeks.ago..Time.now).count
  end

  def find_or_create_job
    Contract.where(owner_id: id).first_or_initialize
  end

  def contracts
    if current_contract
      [current_contract]
    else
      []
    end
  end

  def contract_ids
    contracts.map(&:id)
  end

  def current_offer(caregiver_id)
    if current_contract && caregiver_id
      @current_offer ||= Offer.where(contract_id: current_contract.id, caregiver_id: caregiver_id).first
    else
      nil
    end
  end

  def mailboxer_email object
    return email
  end

  def create_md5hash
    self.md5hash = Digest::MD5.hexdigest(self.email)
  end

  def contacts_based_on_offers
    contacts = []

    mailbox.receipts.each do |receipt|
      r_user = receipt.receiver

      unless contacts.include?(r_user)
        contacts << r_user
      end
    end
    contacts
  end

  def contacts_based_on_contracts
    contacts = []

    contracts.each do |contract|
      user = contract.owner

      unless contacts.include?(user)
        contacts << user
      end
    end

    contacts
  end

  def has_allergies?
    allergies.length > 0
  end

  def allergy_list
    allergies.map { |a| a.name }.join(', ')
  end

  def has_job?
    Contract.where(owner_id: id).length > 0
  end

  def new_offers
    Contract.where(owner_id: id).first.offers_newly_created_count
  end

  def completed_profile?
    contracts.count > 0 && zipcode
  end

  def age
    age = 'N/A'

    if self.date_of_birth
      today = Date.today
      age = today.year - date_of_birth.year
      age -= 1 if date_of_birth.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    end

    age
  end

  def offers
    Offer.where(contract_id: contract_ids)
  end

  def format_name
    if self.first_name_changed?
      self.send("first_name=", self.first_name.downcase.capitalize)
    end

    if self.last_name_changed?
      self.send("last_name=", self.last_name.downcase.capitalize)
    end
  end

  def offer_for_contract contract
    nil
  end

  def avatar
    avatars.length > 0 ?
      avatars.order("created_at DESC").first :
        Avatar::AvatarNullObject.new
  end

  def has_avatar?
    avatars.length > 0
  end

  def total_experience
    xp = self.work_experience ? self.work_experience : 0

    if self.created_at < 1.year.ago
      (Time.now.year - self.created_at.year) + xp
    else
      xp
    end
  end

  def update_contract
    @contract = Contract.find(contract_id)
    @contract.update_attribute :owner, self
  end

  def send_greeting_email
    UserMailer.send_greeting_email(self).deliver_later(wait: 5.seconds)
  end

  def send_interview_guide_email
    UserMailer.send_interview_guide_email(self).deliver_later(wait: 1.day)
  end

  def should_show_congrats_modal?
    congrats_modal == false
  end

  def should_show_edit_profile_modal?
    edit_profile_modal == false
  end

  def create_customer
    result = Braintree::Customer.create(
      :first_name => first_name,
      :last_name => last_name,
      :email => email
    )

    self.customer_id = result.customer.id
    self.save!
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later(wait: 5.seconds)
  end

  def subscribe_to_mailchimp
    SubscribeToMailingListJob.set(wait: 10.minutes).perform_later(self)
  end

  def generate_referral_code
    referral = Digest::SHA1.hexdigest("#{self.class.name.downcase}-#{self.id}")
    self.update_column(:referral_code, referral[0..5].upcase)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ['ID', 'First Name', 'Last Name', 'Email', 'Phone', 'Facebook ID', 'Created At', 'Zipcode', 'Description', 'Patient Name']

      order('created_at DESC').each do |family|
        values = []

        values << family.id
        values << family.first_name
        values << family.last_name
        values << family.email
        values << family.phone
        values << family.facebook_id
        values << family.created_at

        if family.job
          values << family.job.zipcode
          values << family.job.description
          values << family.job.patient_name
        else
          values << 'No Job Found'
          values << 'No Job Found'
          values << 'No Job Found'
        end

        csv << values
      end
    end
  end

  class UserNullObject
    def avatar
      Avatar::AvatarNullObject.new
    end
  end


  class Sort
    OPTIONS = {
      'Distance' => 2,
      'Age (Youngest)' => 3,
      'Age (Oldest)' => 4,
      'CareSpotter Hours' => 5,
      'Experience' => 6,
      'Testimonials' => 7,
      'Hourly Fee' => 8
    }
  end


end
