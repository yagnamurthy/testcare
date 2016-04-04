require 'spec_helper'

describe AvailabilityAndServices do
  
	before(:each) do
		@caregiver = Caregiver.new(email: Faker::Internet.email, password: 'somethingelse1', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
		@caregiver.save!
		@subject = AvailabilityAndServices.new(@caregiver.to_hash, Schedule.by_caregiver_id(@caregiver.id))
		subject { @subject }
	end

  	it { should have(1).error_on(:hourly_rate) }
  	it { should have(1).error_on(:availability) }
  	it { should have(1).error_on(:general_service_ids) }
  	it { should have(1).error_on(:health_service_ids) }
  	it { should have(1).error_on(:technical_service_ids) }

	context '#save' do 
		it 'returns true when the form is valid' do 
			@subject.hourly_rate=12
			@subject.availability=1
			@subject.general_service_ids=[1]
			@subject.health_service_ids=[15]
			@subject.technical_service_ids=[28]
			@subject.schedule_attributes={}
			@subject.save.should eq(true)
		end

		it 'returns false when the form is invalid' do 
			@subject.hourly_rate=nil
			@subject.availability=1
			@subject.general_service_ids=[1]
			@subject.health_service_ids=[15]
			@subject.technical_service_ids=[28]
			@subject.schedule_attributes={}
			@subject.save.should eq(false)
		end
	end
end
