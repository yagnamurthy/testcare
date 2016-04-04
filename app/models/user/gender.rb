module User::Gender
	extend ActiveSupport::Concern

	MALE = { :value => 1, :label => "Male" }
  	FEMALE = { :value => 2, :label => "Female" }
  	UNKNOWN = { :value => 9, :label => "Unknown"}

  	VALUES = [ MALE[:value], FEMALE[:value] ]

	

	def gender_display_name
		return self.gender == MALE[:value] ? MALE[:label] :
			self.gender == FEMALE[:value] ? FEMALE[:label] :
				UNKNOWN[:label]
	end

	def self.options_for_select
		[
			[MALE[:label], MALE[:value]],
			[FEMALE[:label], FEMALE[:value]]
		]
	end


end