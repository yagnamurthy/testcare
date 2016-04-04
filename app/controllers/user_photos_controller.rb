class UserPhotosController < ApplicationController
  before_action :authenticate_user!

  def upload
    @user = current_user
    avatar = Avatar.upload(params['file'], @user)

    render json: { url: avatar.url }
  end
end
