class Pet

	OPTIONS = {
		"1" => "I love pets",
		"2" => "I\'m allergic to dogs",
		"3" => "I\'m allergic to cats",
		"4" => "I\'m allergic to cats and dogs",
		"5" => "Depends on the pet",
		"6" => "No pets please"
	}

	attr_accessor :value, :label

	def initialize(value)
		self.value=value
		self.label= OPTIONS[value.to_s]
	end

	def to_s
		label
	end

	def self.values 
		OPTIONS.keys
	end

end