class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!
  before_action :set_user

  def edit
  end

  def update
    puts user_params.inspect

    if @user.update(user_params)
      redirect_to admin_caregivers_path, notice: "You successfully updated #{@user.full_name}"
    else 
      render action: 'edit'
    end
  end

  private

  def set_user 
    @user = User.find(params[:id])
  end

  def user_params
    params[:caregiver].permit(
      :first_name, :last_name, :zipcode, 
      :phone, :gender, :headline, :bio,
      :hours, :work_experience, :availability,
      :phone, :date_of_birth_month, :date_of_birth_year,
      :date_of_birth_day, experience_ids: [], schools_ids: []
    )
  end
end