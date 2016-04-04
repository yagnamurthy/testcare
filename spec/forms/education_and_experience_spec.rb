require 'spec_helper'

describe EducationAndExperience do
  
	before(:each) do
		@caregiver = Caregiver.new(email: Faker::Internet.email, password: 'somethingelse1', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
		@caregiver.save!
		@subject = EducationAndExperience.new(@caregiver.to_hash, Credential.by_caregiver_id(@caregiver.id), @caregiver.build_resources(School), @caregiver.build_resources(Experience))
		subject { @subject }
	end

  	it { should have(1).error_on(:work_experience) }

	context '#save' do 
		it 'returns true when the form is valid' do 
			@subject.work_experience=15
			@subject.save.should eq(true)
		end

		it 'returns false when the form is invalid' do 
			@subject.work_experience=nil
			@subject.save.should eq(false)
		end
	end
end
