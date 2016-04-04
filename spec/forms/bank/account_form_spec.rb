require 'spec_helper'
require "#{Rails.root}/app/forms/bank/account_form"

describe AccountForm do

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
		it 'fails to save when the routing number is incorrect' do 
			account = AccountForm.new({
		      :account_number => '8887776665555',
		      :name => 'Bank 1',
		      :routing_number => '100000007',
		      :type => 'checking',
		      :user => @user
			})

			account.save.should eq(false)
		end

		it 'saves when everything is okay' do 
			account = AccountForm.new({
			  :account_number => '9900000002',
		      :name => 'Bank 1',
		      :routing_number => '021000021',
		      :type => 'checking',
		      :user => @user
			})

			account.save.should eq(true)
		end
	end
end
