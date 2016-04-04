class Admin::SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!
  before_action :set_school

  def edit
  end

  def update
    puts school_params.inspect

    if @school.update(school_params)
      redirect_to admin_caregivers_path, notice: "You successfully updated #{@school.user.full_name}"
    else 
      render action: 'edit'
    end
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    puts params[:school]
    params[:school].permit(
      :name, :degree, :description, 
      :start_date_year, :finish_date_year
    )
  end

end