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

class Admin < User

	def applied_for_contract? contract 
		false
	end

	def completed_profile?
		false
	end
end
