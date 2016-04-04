# rake populate_caregivers:city[15217]

require 'rake'

namespace :populate_caregivers do

  task :city => :environment do |t, args|
    caregiver_data = YAML::load( File.open( "#{Rails.root}/lib/assets/populate_caregivers.yml" ) )
  	zipcode = "34102".to_s
  	region = zipcode.to_region
  	zipcodes = region.to_zip

    caregiver_data.each_with_index do |caregiver, index|
      zip = zipcodes.sample
      email = caregiver["email"].split("@").first + zip.to_s + index.to_s

      new_caregiver = Caregiver.new({
        first_name: caregiver["first_name"],
        last_name: caregiver["last_name"],
        date_of_birth: caregiver["date_of_birth"],
        gender: caregiver["gender"],
        bio:  caregiver["bio"],
        headline: caregiver["headline"],
        hours: 0,
        work_experience: caregiver["work_experience"],
        zipcode: zip,
        hourly_rate: caregiver["hourly_rate"],
        references_count: 0,
        email: email + "@bjdmedia.com",
        last_sign_in_at: Time.now,
        password: 'password1',
        availability: [1,2,3].sample,
        smokes: [1,2,3].sample,
        indexable: true
      })

      new_caregiver.save!

      Avatar.upload(caregiver["avatar"], new_caregiver)

      Experience.create({
        employer: caregiver["experience_employer"],
        start_date: caregiver["experience_start_date"],
        finish_date: caregiver["experience_finish_date"],
        description: caregiver["experience_description"],
        position: caregiver["experience_position"],
        current: caregiver["current"],
        user_id: new_caregiver.id
      })

      School.create({
        name: caregiver["school_name"],
        degree: caregiver["school_degree"],
        description: caregiver["school_description"],
        start_date_year: caregiver["school_start_date_year"],
        finish_date_year: caregiver["school_finish_date_year"],
        user_id: new_caregiver.id
      })

      puts "Caregiver #{new_caregiver.first_name} created!"

    end

  	# 30.times.each do |show|

  	# 	caregiver = Caregiver.new({
		 #    first_name: Faker::Name.first_name,
		 #    last_name: Faker::Name.last_name,
		 #    date_of_birth: Date.today - (20 + Random.rand(11)).years,
		 #    gender: Random.rand(2) == 0 ? 1 : 2,
		 #    bio:  Faker::Lorem.paragraphs(10).join(","),
		 #    headline: headlines.sample,
		 #    hours: 20 + Random.rand(11),
		 #    work_experience: (1..10).to_a.sample,
		 #    zipcode: zipcodes.sample,
		 #    hourly_rate: 15 + Random.rand(11),
		 #    references_count: 0,
		 #    email: Faker::Name.first_name + "." + Faker::Name.last_name + "@bjdmedia.com",
		 #    last_sign_in_at: Time.now,
		 #    password: 'password1',
		 #    availability: [1,2,3].sample,
		 #    smokes: [1,2,3].sample,
		 #    indexable: true
  	# 	})

  	# 	caregiver.save!

  	# 	avatar = Avatar.new({
  	# 		user_id: caregiver.id,
  	# 		filename: caregivers[0].avatar[0].filename,
  	# 		format: caregivers[0].avatar[0].format,
  	# 		size: caregivers[0].avatar[0].size
  	# 	})

  	# 	avatar.save!

  	# 	puts "#{show}"
  	# end


  end

end
