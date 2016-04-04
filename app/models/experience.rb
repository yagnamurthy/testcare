# == Schema Information
#
# Table name: experiences
#
#  id          :integer          not null, primary key
#  employer    :text(65535)
#  start_date  :date
#  finish_date :date
#  user_id     :integer
#  description :text(65535)
#  position    :string(255)
#  current     :boolean
#

class Experience < ActiveRecord::Base
	include MonthYearDate
	
	belongs_to :user

	AGENCY = { label: 'Agency, Facility, or Institution', value: 1 }
	PRIVATE = { label: 'Private Client', value: 2 }

	validates :position, presence: {
		message: "can't be blank"
	}

	validate :current_work_place_and_finish_date


	def current_work_place_and_finish_date
		if self.current_job? && (!self.finish_date.blank? && !self.finish_date.nil?)
			errors.add(:current, 'cannot be selected when finish date has been entered')
		end
	end

	def self.years
		(0..20)
	end

end
