# == Schema Information
#
# Table name: allergies
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Allergy < ActiveRecord::Base
	has_and_belongs_to_many :users
end
