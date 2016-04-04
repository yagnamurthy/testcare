require 'spec_helper'

describe AdminController do
	render_views

	before(:each) do
    	controller.stub(:current_user).and_return()
	end

	context '#show' do
		it 'responds with 200' do
			get 'show'
			response.should be_success
		end
	end

	context '#caregivers' do
		it 'responds with 200 when logged in as an admin' do
		end

		it 'responds with a 403 when not logged in as an admin' do
		end
	end
end
