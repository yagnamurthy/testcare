class DashboardController < ApplicationController
  before_action :authenticate_user!
  around_action :can_view?, except: :welcome_to_carespotter

  def index
    if current_user.caregiver?
      @caregiver = current_user.decorate
    end
  end

  def welcome_to_carespotter
    if current_user.caregiver?
      current_user.congrats_modal = true
      current_user.save!
      render :welcome_to_carespotter_caregiver
    elsif current_user.family?
      current_user.congrats_modal = true
      current_user.save!
      render :welcome_to_carespotter_family
    end
  end

  private

  def can_view?
    if current_user.caregiver?
      yield
    elsif current_user.family?
      redirect_to mailbox_index_path
    else
      redirect_to '/'
    end
  end
end
