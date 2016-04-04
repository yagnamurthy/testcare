# == Schema Information
#
# Table name: questions
#
#  id      :integer          not null, primary key
#  user_id :integer
#  q1      :string(255)
#  q2      :string(255)
#  q3      :string(255)
#  q4      :string(255)
#

class Question < ActiveRecord::Base

	belongs_to :user

	QUESTIONS = {
		"q1" => "Why did you become a caregiver?",
	}

end
