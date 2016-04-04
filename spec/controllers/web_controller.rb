require 'spec_helper'

describe WebController do
	render_views

	before(:each) do
    	controller.stub(:current_user).and_return(nil)
	end

	context '#show' do
		it 'responds with 200' do
			get 'show'
			response.should be_success
		end
	end

	context '#about_us' do
		it 'responds with 200' do
			get 'about_us'
			response.should be_success
		end
	end

	context '#how_it_works' do
		it 'responds with 200' do
			get 'how_it_works'
			response.should be_success
		end
	end

	context '#contact' do
		it 'responds with 200' do
			get 'contact'
			response.should be_success
		end
	end

	context '#privacy' do
		it 'responds with 200' do
			get 'privacy'
			response.should be_success
		end
	end

	context '#terms_of_service' do
		it 'responds with 200' do
			get 'terms_of_service'
			response.should be_success
		end
	end

	context '#team' do
		it 'responds with 200' do
			get 'team'
			response.should be_success
		end
	end

	context '#become_a_caregiver' do
		it 'responds with 200' do
			get 'become_a_caregiver'
			response.should be_success
		end
	end
end
