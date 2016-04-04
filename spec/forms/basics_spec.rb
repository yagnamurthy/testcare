require 'spec_helper'

describe Basics do
  
	before(:each) do
		@caregiver = Caregiver.new(email: Faker::Internet.email, password: 'somethingelse1', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
		@caregiver.save!
		@subject = Basics.new(@caregiver.to_hash)
		subject { @subject }
	end

  	it { should have(1).error_on(:gender) }
  	it { should have(1).error_on(:date_of_birth_month) }
  	it { should have(1).error_on(:date_of_birth_day) }
  	it { should have(1).error_on(:date_of_birth_year) }
  	it { should have(1).error_on(:pets) }
  	it { should have(1).error_on(:smokes) }
  	it { should have(1).error_on(:transportation) }
  	it { should have(1).error_on(:zipcode) }
  	it { should have(1).error_on(:phone) }

	context '#save' do 
		it 'returns true when the form is valid' do 
			@subject.gender=1
			@subject.date_of_birth_year=1990
			@subject.date_of_birth_month=10
			@subject.date_of_birth_day=10
			@subject.pets=1
			@subject.smokes=1
			@subject.transportation=1
			@subject.zipcode=15217
			@subject.phone="123-123-1234"
			@subject.language_ids= ['EN', 'ES']
			@subject.allergy_ids= [1,2]
			@subject.save.should eq(true)
		end

		it 'returns false when the form is invalid' do 
			@subject.gender=1
			@subject.date_of_birth_year=1990
			@subject.date_of_birth_month=10
			@subject.date_of_birth_day=10
			@subject.pets=nil
			@subject.smokes=1
			@subject.transportation=1
			@subject.zipcode=nil
			@subject.phone="123-123-1234"
			@subject.save.should eq(false)
		end
	end
end
