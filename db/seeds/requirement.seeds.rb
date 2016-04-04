require "rubygems"

requirements = [ 
	[ '1', 'Female caregiver preferred' ],
	[ '2', 'Male caregiver preferred' ],
	[ '3', 'Hospice Experience' ],
	[ '4', 'Non-Smoker' ],
	[ '5', 'Transportation necessary' ],
	[ '6', 'Pet Lover' ],
	[ '7' , 'CNA Preferred' ],
	[ '8', 'LPN/RN Preferred' ]
]

Requirement.delete_all

requirements.each do |requirement|
	@requirement = Requirement.create!(id: requirement[0], name: requirement[1])
	puts "#{@requirement.name} was created." if Rails.env.development? || Rails.env.production?
end