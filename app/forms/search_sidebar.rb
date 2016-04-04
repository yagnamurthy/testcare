class SearchSidebar

	include ActiveModel::Conversion
	extend  ActiveModel::Naming

	attr_accessor :zipcode,
				  :gender,
				  :language,
				  :transportation,
				  :keywords,
				  :wage,
				  :live_in,
				  :is_RN,
				  :is_CNA,
				  :is_LVN,
				  :is_HHA,
				  :degree,
				  :pets,
				  :no_allergies,
				  :non_smoker,
				  :has_hospice,
				  :page,
				  :services,
          :health_services

	def initialize obj
		self.zipcode = obj[:zipcode]
		self.page = obj[:page] || 1

		if obj[:s]
			self.gender = obj[:s][:gender]
			self.language = obj[:s][:language]
			self.transportation = obj[:s][:transportation]
			self.keywords = obj[:s][:keywords]
			self.wage = obj[:s][:wage]
			self.live_in = obj[:s][:live_in]
			self.is_RN = obj[:s][:is_RN]
			self.is_CNA = obj[:s][:is_CNA]
			self.is_LVN = obj[:s][:is_LVN]
			self.is_HHA = obj[:s][:is_HHA]
			self.degree = obj[:s][:degree]
			self.pets = obj[:s][:pets]
			self.no_allergies = obj[:s][:no_allergies]
			self.non_smoker = obj[:s][:non_smoker]
			self.has_hospice = obj[:s][:has_hospice]
			self.services = obj[:s][:services]
      self.health_services = obj[:s][:health_services]
		else
			self.wage ="1-50"
			self.services = []
		end
	end

	def services= current_services
		services = []

		if current_services
			current_services.each do |key, value|
				if value.to_i != 0
					unless services.include? value
						services << key
					end
				end
			end
		end

		@services = services.length > 0 ? services : []
	end

	def persisted?
		false
	end
end
