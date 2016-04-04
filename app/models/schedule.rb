# == Schema Information
#
# Table name: schedules
#
#  id                      :integer          not null, primary key
#  monday_morning          :boolean          default(FALSE)
#  monday_afternoon        :boolean
#  monday_mid_afternoon    :boolean          default(FALSE)
#  monday_evening          :boolean          default(FALSE)
#  monday_overnight        :boolean          default(FALSE)
#  tuesday_morning         :boolean          default(FALSE)
#  tuesday_afternoon       :boolean          default(FALSE)
#  tuesday_mid_afternoon   :boolean          default(FALSE)
#  tuesday_evening         :boolean          default(FALSE)
#  tuesday_overnight       :boolean          default(FALSE)
#  wednesday_morning       :boolean          default(FALSE)
#  wednesday_afternoon     :boolean          default(FALSE)
#  wednesday_mid_afternoon :boolean          default(FALSE)
#  wednesday_evening       :boolean          default(FALSE)
#  wednesday_overnight     :boolean          default(FALSE)
#  thursday_morning        :boolean          default(FALSE)
#  thursday_afternoon      :boolean          default(FALSE)
#  thursday_mid_afternoon  :boolean          default(FALSE)
#  thursday_evening        :boolean          default(FALSE)
#  thursday_overnight      :boolean          default(FALSE)
#  friday_morning          :boolean          default(FALSE)
#  friday_afternoon        :boolean          default(FALSE)
#  friday_mid_afternoon    :boolean          default(FALSE)
#  friday_evening          :boolean          default(FALSE)
#  friday_overnight        :boolean          default(FALSE)
#  saturday_morning        :boolean          default(FALSE)
#  saturday_afternoon      :boolean          default(FALSE)
#  saturday_mid_afternoon  :boolean          default(FALSE)
#  saturday_evening        :boolean          default(FALSE)
#  saturday_overnight      :boolean          default(FALSE)
#  sunday_morning          :boolean          default(FALSE)
#  sunday_afternoon        :boolean          default(FALSE)
#  sunday_mid_afternoon    :boolean          default(FALSE)
#  sunday_evening          :boolean          default(FALSE)
#  sunday_overnight        :boolean          default(FALSE)
#  user_id                 :integer
#  contract_id             :integer
#

class Schedule < ActiveRecord::Base
	belongs_to :user
  belongs_to :contract

	DAY = {
		"0" => "Monday",
		"1" => "Tuesday",
		"2" => "Wednesday",
		"3" => "Thursday",
		"4" => "Friday",
		"5" => "Saturday",
		"6" => "Sunday"
	}

	TIME = {
		"0" => "Morning",
		"1" => "Afternoon",
		"2" => "Mid Afternoon",
		"3" => "Evening",
		"4" => "Overnight"
	}

	def self.by_caregiver_id caregiver_id
		potential_schedule = where(user_id: caregiver_id)[0]

		if potential_schedule.nil?
			potential_schedule = Schedule.create(user_id: caregiver_id)
		end

		potential_schedule
	end
end
