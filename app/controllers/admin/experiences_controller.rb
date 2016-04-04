class Admin::ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!
  before_action :set_experience


  def edit
  end

  def update
    puts experience_params.inspect

    if @experience.update(experience_params)
      redirect_to admin_caregivers_path, notice: "You successfully updated #{@experience.user.full_name}"
    else 
      render action: 'edit'
    end
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params[:experience].permit(
      :employer, :start_date_month, :start_date_year, 
      :finish_date_month, :finish_date_year, 
      :description, :position, :current
    )
  end

end