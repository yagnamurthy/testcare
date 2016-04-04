class RegistrationController < ApplicationController
    before_action :authenticate_user!
    # before_action :verify_caregiver!
    before_action :build_caregiver, except: [:update]


  def update
    if is_avatar_upload?
      Avatar.upload(params[:caregiver][:avatar][:file], current_user)
    end

    if current_user.update(caregiver_params)
      if is_dashboard_path?
        redirect_to dashboard_path
      else
        redirect_to params[:route]
      end
    else
      raise 'could not save caregiver'
    end
  end


  private

  def is_dashboard_path?
    referrer = Rails.application.routes.recognize_path(URI(request.referer).path)

    if referrer[:controller] == 'caregivers' || referrer[:controller] == 'dashboard'
      return true
    end

    return false
  end

  def is_avatar_upload?
    (params[:caregiver] && params[:caregiver][:avatar] && params[:caregiver][:avatar][:file])
  end

  def caregiver_params
    params[:caregiver].permit(
      :gender, :date_of_birth_month,
      :date_of_birth_day, :date_of_birth_year,
      :zipcode, :phone, :smokes, :pets,
      :hourly_rate, :live_in, :live_in_rate, :availability,
      :work_experience,  :hometown,
      :bio, :question_1, :question_2, :question_3, :question_4,
      :background,
      schedule_attributes: schedule_attr_symbols,
      credential_attributes: credential_attr_symbols,
      language_ids: [], allergy_ids: [],
      health_service_ids: [], general_service_ids: [], technical_service_ids: [], skill_service_ids: [])
  end

  def schedule_attr_symbols
    [ :monday_morning, :monday_afternoon, :monday_mid_afternoon,
    :monday_evening, :monday_overnight, :tuesday_morning,
    :tuesday_afternoon, :tuesday_mid_afternoon, :tuesday_evening,
    :tuesday_overnight, :wednesday_morning, :wednesday_afternoon,
    :wednesday_mid_afternoon, :wednesday_evening, :wednesday_overnight,
    :thursday_morning, :thursday_afternoon, :thursday_mid_afternoon,
    :thursday_evening, :thursday_overnight,
    :friday_morning, :friday_afternoon, :friday_mid_afternoon,
    :friday_evening, :friday_overnight, :saturday_morning,
    :saturday_afternoon, :saturday_mid_afternoon, :saturday_evening,
    :saturday_overnight, :sunday_morning, :sunday_afternoon,
    :sunday_mid_afternoon, :sunday_evening, :sunday_overnight ]
  end

  def credential_attr_symbols
    [
        :HHA, :HHANumber, :CNA, :CNANumber,
        :LVN, :LVNNumber, :RN, :RNNumber, :CPR, :CPRNumber, :other
    ]
  end

  def build_caregiver
    current_user.credential || current_user.build_credential
    current_user.schedule || current_user.build_schedule
  end
end
