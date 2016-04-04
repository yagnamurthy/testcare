# == Schema Information
#
# Table name: trainings
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  start_date  :date
#  finish_date :date
#  description :text(65535)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Training < ActiveRecord::Base
	
	belongs_to :user

	validates :start_date, presence: true

	attr_accessor :start_date_month, :start_date_year
	
	before_validation :set_start_date

  after_initialize :set_start_complex_start_date





	def start_date_in_words
    	"#{self.start_date.strftime("%b")} #{self.start_date.strftime("%Y")}"
  	end

	def self.months
      unless @months
        @months = []
        (1..12).each {|m| @months << [Date::MONTHNAMES[m], m] }
      end
      @months
    end

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

  private

  def set_start_date
    if self.start_date_year && self.start_date_month
      self.start_date = self.class.create_date(self.start_date_year, self.start_date_month)
    end
  end

  def set_start_complex_start_date
    if self.start_date
      self.start_date_month = self.start_date.month 
      self.start_date_year = self.start_date.year
    end
  end

end
