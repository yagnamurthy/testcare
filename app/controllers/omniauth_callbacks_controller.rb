require_dependency "facebook"

class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook

    @user = Facebook.find_or_create_instance(
                request.env['omniauth.auth'], 
                params['type'])


    sign_in @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    
    respond_to do |format|
  		format.json { render :json => { 'redirectLink' => after_sign_in_path_for(@user) } }
	end

  end
end