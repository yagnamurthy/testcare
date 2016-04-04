# == Schema Information
#
# Table name: services
#
#  id   :integer          not null, primary key
#  name :string(255)
#  type :string(255)
#

class Service < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :contracts

	def self.general
		where(:type => 'GeneralService').order('name ASC')
	end

	def self.health
		where(:type => 'HealthService').order('name ASC')
	end

	def self.technical
		where(:type => 'TechnicalService').order('name ASC')
	end

	def self.skill
		where(:type => 'SkillService').order('name ASC')
	end
end
