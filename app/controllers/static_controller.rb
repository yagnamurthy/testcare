class StaticController < ApplicationController

	def landing_page
	  @yelp_data = YelpSearch.new().search('32801')
	  @caregivers = Caregiver::Search.new({zipcode: '32801'}).search.results
	  @custom_google_api = true
	end

	def seo

	end

end
