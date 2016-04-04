#require 'oj'
require 'zip_code_converter'

class Caregiver::Search

  attr_accessor :services, :health_services, :miles, :keywords, :sort, :keywords, :zipcode, :per_page,
          :work_experience, :availability, :gender, :transportation,
          :page, :wage, :lat_lng, :language, :is_RN, :is_LVN,
          :is_CNA, :is_HHA, :non_smoker, :no_allergies, :sort, :degree, :has_hospice, :likes_pets, :live_in


  SORT= {
    "1" => "Relavance",
    "2" => "Distance",
    "3" => "Age (Youngest)",
    "4" => "Age (Oldest)",
    "5" => "Carespotter Hours",
    "6" => "Experience",
    "7" => "Testimonials",
    "8" => "Hourly Rate"
  }

  def initialize(query_object)
    self.miles = query_object[:miles] || 25
    self.zipcode = query_object[:zipcode]
    self.page = query_object[:page] || 1
    self.sort = query_object[:sort] || "1"
    self.per_page = query_object[:per_page] || 10

    query_object = query_object[:s]

    if query_object && query_object[:health_services]
      query_object[:services] = [] unless query_object[:services]
      query_object[:services] << query_object[:health_services]
    end

    self.services = query_object && query_object[:services] || []
    self.keywords = query_object && query_object[:keywords]
    self.gender = query_object && query_object[:gender]
    self.is_RN = query_object && query_object[:is_RN] || nil
    self.is_LVN = query_object && query_object[:is_LVN] || nil
    self.is_HHA = query_object && query_object[:is_HHA] || nil
    self.is_CNA = query_object && query_object[:is_CNA] || nil
    self.work_experience = query_object && query_object[:work_experience] || nil
    self.live_in = query_object && query_object[:live_in]
    self.transportation = query_object && query_object[:transportation] || nil
    self.wage = query_object && query_object[:wage] || nil
    self.language = query_object && query_object[:language] || nil
    self.non_smoker = query_object && query_object[:non_smoker] || nil
    self.no_allergies = query_object && query_object[:no_allergies] || nil
    self.degree = query_object && query_object[:degree] || nil
    self.has_hospice = query_object && query_object[:has_hospice] || nil
    self.likes_pets = query_object && query_object[:pets] || nil

  end

  def zipcode= zipcode
    if zipcode
      @lat_lng = Geocoder.coordinates(zipcode).join(',')
      @zipcode = Geocoder.search(@lat_lng).first.postal_code
    else
      raise "Must enter a zipcode"
    end
  end

  def sanitize_code code
    final_code = nil

    if code.match(/\d{5}/)
      final_code = code.to_s
    else
      final_code = code.to_zip[0]
    end

    final_code
  end

  def gender= gender
    if gender == "1" || gender == "2"
      @gender = gender.to_i
    else
      @gender = nil
    end
  end


  def wage= wage
    wage_object = {}

    if wage && wage != ""
      wage = wage.split("-")
    else
      wage = ["1", "50"]
    end

    wage_object[:from] = wage[0].to_i
    wage_object[:to] = wage[1].to_i

    @wage = wage_object
  end

  def services= current_services
    current_services = current_services
                        .flatten
                        .compact
                        .reject(&:blank?)
                        .map(&:to_i)
                        .reject(&:zero?)

    @services = current_services && current_services.length > 0 ? current_services : []
  end

  def keywords= keywords
    @keywords = (keywords == "" || keywords.nil?) ? nil : keywords
  end

  def transportation= transportation
    @transportation = transportation && transportation != "" && transportation != 0 && transportation != "0" ? transportation.to_i : nil
  end

  # def availability= availability
  #   @availability = availability && !availability.to_i == "0" ? availability.to_i : nil
  # end

  def language= language
    @language = (language == "" || language.nil?) ? nil : language
  end

  def degree= degree
    @degree = (degree == "" || degree.nil? || degree == "0") ? nil : true
  end

  def work_experience= work_experience
    work_experience_object = {}

    work_experience_object[:to] = 30
    work_experience_object[:from] = work_experience.nil? || work_experience=="" ? 1 : work_experience

    @work_experience = work_experience_object
  end

  def has_hospice= has_hospice
    @has_hospice = (has_hospice == "" || has_hospice.nil? || has_hospice == "0") ? nil : true
  end

  def likes_pets= likes_pets
    @likes_pets = (likes_pets == "" || likes_pets.nil? || likes_pets == "0") ? nil : true
  end

  def live_in= live_in
    @live_in = (live_in == "" || live_in.nil? || live_in == "0") ? nil : true
  end

  def is_RN= is_RN
    @is_RN = (is_RN == "" || is_RN.nil? || is_RN == "0") ? nil : true
  end

  def is_CNA= is_CNA
    @is_CNA = (is_CNA == "" || is_CNA.nil? || is_CNA == "0") ? nil : true
  end

  def is_LVN= is_LVN
    @is_LVN = (is_LVN == "" || is_LVN.nil? || is_LVN == "0") ? nil : true
  end

  def is_HHA= is_HHA
    @is_HHA = (is_HHA == "" || is_HHA.nil? || is_HHA == "0") ? nil : true
  end

  def non_smoker= non_smoker
    @non_smoker = (non_smoker == "" || non_smoker.nil? || non_smoker == "0") ? nil : true
  end

  def no_allergies= no_allergies
    @no_allergies = (no_allergies == "" || no_allergies.nil? || no_allergies == "0") ? nil : true
  end

  def searchable?
    true
  end

  def search
    util = self

      Caregiver.search load:true, :page => util.page, :per_page => util.per_page do
        if util.searchable?
          sort do
            if util.sort == "2" || util.sort == "1"
              by "_geo_distance", "lat_lng" => "#{util.lat_lng}", "unit" => "miles"
            elsif util.sort == "3"
              by :age, "asc"
            elsif util.sort == "4"
              by :age, "desc"
            elsif util.sort == "5"
              by :carespotter_hours, "desc"
            elsif util.sort == "6"
              by :work_experience, "desc"
            elsif util.sort == "7"
              by :testimonials, "desc"
            elsif util.sort == "8"
              by :hourly_rate, "asc"
            elsif util.sort == "9"
              by :updated_at, "desc"
            end
          end
      end
      query do
        filtered do
          filter :terms, languages: [util.language] unless util.language.nil?
          filter :terms, services: util.services unless util.services.nil? || util.services.blank?
          filter :geo_distance, { lat_lng: util.lat_lng, distance: "#{util.miles}mi" }

          if util.gender || util.keywords || util.is_CNA || util.is_LVN || util.is_HHA || util.is_RN || util.degree || util.live_in
            query do
              boolean do
                must { string "#{util.keywords}" } unless util.keywords.nil?

                must { string "gender:#{util.gender}" } unless util.gender.nil?

                must { term :is_CNA, util.is_CNA } unless util.is_CNA.nil?
                must { term :is_LVN, util.is_LVN } unless util.is_LVN.nil?
                must { term :is_HHA, util.is_HHA } unless util.is_HHA.nil?
                must { term :is_RN, util.is_RN } unless util.is_RN.nil?
                must { term :live_in, util.live_in } unless util.live_in.nil?

                must { term :degree, util.degree } unless util.degree.nil?
              end # boolean
            end # query
          end #if
        end #filtered
      end
    end
  end
end
