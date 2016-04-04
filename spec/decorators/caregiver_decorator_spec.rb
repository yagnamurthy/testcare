require 'spec_helper'

describe CaregiverDecorator do 

	before(:each) do 
		caregiver = Caregiver.create({
		    first_name: Faker::Name.first_name,
		    last_name: Faker::Name.last_name,
		    age: 20 + Random.rand(11),
		    gender: Random.rand(2) == 0 ? 1 : 2,
		    bio:  Faker::Lorem.paragraphs(10).join(","),
		    headline: Faker::Lorem.sentences(1).join(","),
		    hours: 20 + Random.rand(11),
		    work_experience: (1..10).to_a.sample,
		    zipcode: "pittsburgh".to_zip.sample.to_s,
		    hourly_rate: 15 + Random.rand(11),
		    references_count: 0,
		    email: Faker::Internet.email,
		    last_sign_in_at: Time.now,
		    password: 'password1',
		    avatar: URI.parse(UIFaces::face),
		    availability: [1,2,3].sample,
		    smokes: [1,2,3].sample
		})

		@caregiver = caregiver.decorate
	end

	

end
