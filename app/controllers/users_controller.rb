class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit]

  def index
    respond_to do |format|
      families = User.families
      csv_data = families.to_csv

      format.csv { send_data csv_data }
    end
  end

  # GET /users/1/edit
  def edit
  end

  def link_facebook
    @user = current_user
  end

  def shared_connections
    @user = current_user
  end

  def edit_account; end

  def edit_profile_modal
    if current_user.caregiver?
      current_user.edit_profile_modal = true
      current_user.save!
    end
  end


  # PATCH/PUT /users/1
  def update
    @user = User.find(current_user.id)

    if !user_params_with_password[:password].nil? && !user_params_with_password[:password].blank?
      if @user.update_with_password(user_params_with_password)
        sign_in @user, :bypass => true
        redirect_to dashboard_path
      else
        render action: 'edit'
      end
    else
      if @user.update(user_params)
        if @user.sign_in_count > 1
          redirect_to dashboard_path, notice: 'User was successfully updated.'
        else
          redirect_to dashboard_path(t: 1), notice: 'User was successfully updated.'
        end
      else
        render action: 'edit'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit(:first_name, :last_name, :zipcode, :phone, :avatar, :crop_y, :crop_x, :crop_h, :crop_w, affiliates_ids: [])
    end

    def user_params_with_password
      params[:user].permit(:first_name, :last_name, :zipcode, :password, :password_confirmation, :current_password, :phone, :avatar, :crop_y, :crop_x, :crop_h, :crop_w, affiliates_ids: [])
    end
end
