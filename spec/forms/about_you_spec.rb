require 'spec_helper'

describe AboutYou do
  
	before(:each) do
		@caregiver = Caregiver.new(email: Faker::Internet.email, password: 'somethingelse1', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
		@caregiver.save!
		@subject = AboutYou.new(@caregiver.to_hash)
		subject { @subject }
	end

  	it { should have(1).error_on(:bio) }
  	it { should have(1).error_on(:headline) }

	context '#save' do 
		it 'returns true when the form is valid' do 
			@subject.bio='Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ullamcorper rutrum turpis, sed placerat ligula facilisis ut. Donec ac sollicitudin neque, tincidunt laoreet arcu. Vestibulum purus sem, posuere ac placerat et, laoreet id neque. Fusce dignissim eros ipsum, quis tempus purus placerat non. Vestibulum eget tortor aliquam, semper justo tincidunt, cursus turpis. Morbi a pharetra augue. Nulla non urna et turpis rutrum tincidunt. Curabitur pulvinar euismod scelerisque. Duis convallis dolor ac risus fermentum, a accumsan.'
			@subject.headline='this is a headline'
			@subject.affiliate_ids= [1,2]
			@subject.save.should eq(true)
		end

		it 'returns false when the form is invalid' do 
			@subject.bio=nil
			@subject.headline=nil
			@subject.affiliate_ids= [1,2]
			@subject.save.should eq(false)
		end
	end
end
