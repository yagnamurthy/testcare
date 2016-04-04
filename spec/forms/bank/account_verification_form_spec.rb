require 'spec_helper'
require "#{Rails.root}/app/forms/bank/account_verification_form"

describe AccountVerificationForm do

	before(:each) do 
		@user = User.new(
			first_name: Faker::Name.first_name, 
			last_name: Faker::Name.last_name, 
			password: 'password1',
			email: Faker::Internet.email
		)
		@user.save!
	end	

  
	context '#save' do 
		it 'saves without issue' do 
		end

		it 'fails but still has opportunities to succeed' do 
		end

		it 'fails and doesn\'t have anymore opportunities' do 
		end
	end
end
