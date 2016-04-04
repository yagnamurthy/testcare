# == Schema Information
#
# Table name: offers
#
#  id              :integer          not null, primary key
#  caregiver_id    :integer
#  contract_id     :integer
#  rate            :integer
#  status          :integer          default(1)
#  created_at      :datetime
#  updated_at      :datetime
#  contract_type   :integer
#  conversation_id :integer
#

class Offer < ActiveRecord::Base
	belongs_to :contract
	belongs_to :caregiver
	has_many :messages, :through => :contract
	has_one :conversation

	accepts_nested_attributes_for :messages

	NEW = 1
	ACCEPTED = 2
	DECLINED = 3

	attr_accessor :close_job, :terms_and_conditions, :cover_letter, :body

	scope :newly_created, -> { where(status: NEW) }
	scope :accepted, -> { where(status: ACCEPTED) }
	scope :declined, -> { where(status: DECLINED) }
	scope :active, -> { where(status: [ACCEPTED, NEW]) }

	def new?
		status == 1
	end

	def accepted?
		status == 2
	end

	def declined?
		status == 3
	end

	def status_to_words
		if status == 1
			'New'
		elsif status == 2
			'Accepted'
		elsif status == 3
			'Declined'
		end
	end

	def self.get_based_on_message message
		Offer.where(conversation_id: message.id).first
	end

end
