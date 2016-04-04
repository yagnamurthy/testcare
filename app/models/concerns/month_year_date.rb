module MonthYearDate
  extend ActiveSupport::Concern

  included do

    attr_accessor :start_date_month, 
                  :start_date_year, 
                  :finish_date_month, 
                  :finish_date_year

    validate :start_before_finish
    validates :start_date, presence: true
    validates :finish_date, presence: true, unless: :current_job?

    before_validation :set_start_date
    before_validation :set_finish_date

    after_initialize :set_start_complex_start_date
    after_initialize :set_start_complex_finish_date

  end

  module ClassMethods
    def months
      unless @months
        @months = []
        (1..12).each {|m| @months << [Date::MONTHNAMES[m], m] }
      end
      @months
    end

    def years_since_1960
      unless @years_since_1960
        @years_since_1960 = (1960..Time.now.year)
      end
      @years_since_1960
    end

    def create_date year, month
      if !year.blank? || !month.blank?
        Date.new year.to_i, month.to_i
      end
    end
  end

  def start_and_finish_range_to_words
    if !self.current.nil? && self.current == true
      "#{self.start_date_in_words} to Present"
    else
      "#{self.start_date_in_words} to #{self.finish_date_in_words}"
    end
  end

  def start_date_in_words
    "#{self.start_date.strftime("%b")} #{self.start_date.strftime("%Y")}"
  end

  def finish_date_in_words
    "#{self.finish_date.strftime("%b")} #{self.finish_date.strftime("%Y")}"
  end

  def start_before_finish
    unless current_job?
      if (self.start_date && self.finish_date) && self.start_date > self.finish_date
        errors.add(:finish_date, 'must come after start date')
      end
    end
  end

  def set_start_complex_start_date
    if self.start_date
      self.start_date_month = self.start_date.month 
      self.start_date_year = self.start_date.year
    end
  end

  def set_start_complex_finish_date
    if self.finish_date
      self.finish_date_month = self.finish_date.month 
      self.finish_date_year = self.finish_date.year
    end
  end

  def current_job?
    self.current
  end


  private

  def set_start_date
    self.start_date_month = self.start_date_month == "" ? "01" : self.start_date_month

    if self.start_date_year && self.start_date_month
      self.start_date = self.class.create_date(self.start_date_year, self.start_date_month)
    end
  end

  def set_finish_date
    unless current_job?
      self.finish_date_month = self.finish_date_month == "" ? "01" : self.finish_date_month

      if self.finish_date_year && self.finish_date_month
        self.finish_date = self.class.create_date(self.finish_date_year, self.finish_date_month)
      end
    else
      self.finish_date_month = ""
      self.finish_date_year = ""
      self.finish_date = ""
    end
  end
end