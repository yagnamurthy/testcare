require "rubygems"

allergies = [ 
	[ '1', 'Cats' ],
	[ '2', 'Dogs' ],
	[ '3', 'Animals' ],
	[ '4', 'Dust' ],
	[ '5', 'Perfume' ],
	[ '6', 'Smoking' ]
]

Allergy.delete_all

allergies.each do |allergy|
	@allergy = Allergy.create!(id: allergy[0], name: allergy[1])
	puts "#{@allergy.name} was created." if Rails.env.development? || Rails.env.production?
end