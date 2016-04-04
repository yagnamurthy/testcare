require_dependency 'geo_data'

class WebController < ApplicationController
  before_action :homepage_nav

  # this need to be moved out into their own respective contorllers
  def add_photo_modal;end
  def sign_in_modal;end
  def create_job_modal;end
  def create_job_2_modal;end
  def new_message_modal;end
  def apply_care_job_modal;end
  def login_modal;end
  def reference_request_model;end
  def application_hire_modal;end
  def application_msg_modal;end
  def register_thanks_modal;end

  def homepage_nav
    if current_user && current_user.caregiver? && request.path == '/'
      redirect_to dashboard_path
    elsif current_user && current_user.family? && request.path == '/'
      redirect_to inbox_mailbox_index_path
    end
  end
end
