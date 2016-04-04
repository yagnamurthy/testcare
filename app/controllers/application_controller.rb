require "application_responder"
require 'geo_data'

require_dependency 'permission_error'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  respond_to :html, :json
  protect_from_forgery with: :exception

  rescue_from PermissionError, :with => :handle_permission_exception

  layout 'application'



    # Make sure the user fills out their zipcode
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Caregiver) && current_user.sign_in_count <= 1
      caregiver_registration_path
    elsif resource_or_scope.is_a?(User) && current_user.sign_in_count <= 1
      family_job_path
    else
      if resource_or_scope.is_a?(Caregiver) && resource_or_scope.completed_profile? == false
        caregiver_registration_path
      elsif request.env['omniauth.origin']
        request.env['omniauth.origin']
      else
        if session[:passthru_uri]
          session[:passthru_uri]
        else
          if resource_or_scope.is_a?(Admin)
            admin_dashboard_path
          else
            dashboard_path
          end
        end
      end
    end
  end


  def verify_caregiver!
    Guardian.new(current_user).ensure_caregiver!
  end

  def verify_family!
    Guardian.new(current_user).ensure_family!
  end

  def verify_admin!
    Guardian.new(current_user).ensure_admin!
  end

  def title
    @title || 'CareSpotter | Find a Caregiver'
  end
  helper_method :title

  def description
    @description || ''
  end
  helper_method :description

  def regional_information
    @regional_information ||=
      if params[:zipcode]
        Geocoder.search(params[:zipcode]).first
      else
        if current_user.zipcode
          lat_lng = current_user.zipcode.to_latlon.split(', ')
          OpenStruct.new(lat: lat_lng[0], lng: lat_lng[1], address: current_user.zipcode.to_region)
        else
          location = request.location
          OpenStruct.new(lat: location.latitude, lng: location.longitude, address: location.city)
        end
      end
  end
  helper_method :regional_information

  def current_user
    return super if super.nil?
    return super if super.family?

    CaregiverDecorator.decorate(super)
  end
  helper_method :current_user


 protected

  def devise_parameter_sanitizer
    if params[:user] && params[:user][:type] == 'Caregiver'
      params["caregiver"] = params["user"]
      Caregiver::ParameterSanitizer.new(Caregiver, :caregiver, params)
    elsif params[:user]
      params[:user] = params[:user].merge(type: 'User', contract_id: params[:contract_id])
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  private

  def redirect_to_carespotter_if_beta_url
    redirect_to "http://www.carespotter.com" + request.fullpath
  end

  def eligible_for_redirect?
    Rails.env.production? && !request.host.match(/heroku/).nil?
  end

  def handle_permission_exception
    redirect_to dashboard_path, notice: 'You do not have the proper permissions to access this page.'
  end
end
