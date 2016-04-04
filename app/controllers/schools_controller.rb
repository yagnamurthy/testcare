class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def new
    @school = School.new
  end

  def create
    @school = current_user.schools.new(school_params)

    if @school.save
      redirect_to caregiver_path(current_user)
    else
      render action: 'new'
    end
  end

  def edit
    @school = current_user.schools.find(params[:id])
  end

  def update
    @school = current_user.schools.find(params[:id])

    if @school.update(school_params)
        redirect_to dashboard_path
    else
        render action: 'edit'
    end
  end

  private

    def school_params
      params.require(:school).permit(:name, :degree, :start_date_year, :finish_date_year)
    end

end
