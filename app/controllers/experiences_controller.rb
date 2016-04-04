class ExperiencesController < ApplicationController
  before_action :authenticate_user!

  def new
    @experience = Experience.new
  end

  def create
    @experience = current_user.experiences.new(experience_params)

    if @experience.save
      redirect_to caregiver_path(current_user)
    else
      render action: 'new'
    end
  end

  def edit
    @experience = current_user.experiences.find(params[:id])
  end

  def update
    @experience = current_user.experiences.find(params[:id])

    if @experience.update(experience_params)
        redirect_to dashboard_path
    else
        render action: 'edit'
    end
  end

  private

    def experience_params
      params.require(:experience).permit(:employer, :position, :start_date_year, :start_date_month, :finish_date_year, :finish_date_month)
    end

end

