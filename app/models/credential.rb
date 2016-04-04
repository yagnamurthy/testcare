# == Schema Information
#
# Table name: credentials
#
#  id         :integer          not null, primary key
#  HHA        :boolean          default(FALSE)
#  LVN        :boolean          default(FALSE)
#  CNA        :boolean          default(FALSE)
#  RN         :boolean          default(FALSE)
#  HHANumber  :string(255)
#  LVNNumber  :string(255)
#  CNANumber  :string(255)
#  RNNumber   :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  other      :boolean          default(FALSE)
#  CPR        :boolean          default(FALSE)
#  CPRNumber  :string(255)
#

class Credential < ActiveRecord::Base
	belongs_to :user

	TYPES = [
		{:key => :is_RN, :value => 'Registered Nurse (RN)'}, 
		{:key => :is_CNA, :value => 'Certified Nursing Assistant (CNA)'}, 
		{:key => :is_LVN, :value => 'Licensed Practical Nurse (LPN)'}, 
		{:key => :is_HHA, :value => 'Home Health Aide (HHA)'}
	]

	validate :credential_validate


	def credential_selected
		self.RN || self.CNA || self.LVN || self.HHA || self.other
	end

	def credential_validate
		if !credential_selected
			errors.add(:credential, 'must have one selection')
		end
	end

	def self.by_caregiver_id caregiver_id
		potential_credential = where(user_id: caregiver_id)[0]

		if potential_credential.nil?
			potential_credential = Credential.create(user_id: caregiver_id)
		end

		potential_credential
	end
end
