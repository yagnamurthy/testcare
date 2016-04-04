# == Schema Information
#
# Table name: schools
#
#  id               :integer          not null, primary key
#  name             :text(65535)
#  degree           :integer
#  user_id          :integer
#  description      :text(65535)
#  start_date_year  :integer
#  finish_date_year :integer
#

class School < ActiveRecord::Base
	belongs_to :user

	DEGREES = [
		{label: "Master's Degree", value: 1},
		{label: "Bachelor's Degree", value: 2},
		{label: "Associate's Degree", value: 3},
		{label: "Certificate", value: 4},
		{label: "Vocational School", value: 5},
		{label: "Other", value: 6}
	]

	validates :name, presence: {
		message: 'must have a name'
	}

	validates :start_date_year, presence: {
		message: 'must have a start date year'
	}

	validates :finish_date_year, presence: {
		message: 'must have a finish date year'
	}

	validate :start_year_before_finish_year

    def self.years_since_1960
      unless @years_since_1960
        @years_since_1960 = (1960..Time.now.year)
      end
      @years_since_1960
    end

    def self.create_date year, month
      if !year.blank? || !month.blank?
        Date.new year.to_i, month.to_i
      end
  	end

  	def start_year_before_finish_year
  		if self.start_date_year && self.finish_date_year
  			unless (self.start_date_year <= self.finish_date_year)
  				errors.add(:finish_date_year, "must be after start year")
  				false
  			end
  		end
  	end

	def degree_in_words
		DEGREES.each do |d|
			return d[:label] if d[:value] == self.degree
		end
	end

	def self.degree_options
		DEGREES.map do |degree|
			[degree[:label], degree[:value]]
		end
	end

end
