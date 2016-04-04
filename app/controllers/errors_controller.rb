require_dependency 'geo_data'

class ErrorsController < ApplicationController
 
  def show
  	@search_info = GeoData.new(request.remote_ip).to_s
    render status_code.to_s, :status => status_code
  end
 
protected
 
  def status_code
    params[:code] || 500
  end
 
end
