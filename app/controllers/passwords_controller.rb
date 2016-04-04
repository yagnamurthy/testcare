class PasswordsController < Devise::PasswordsController
  attr_reader :email

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(self.resource, resource_name))
    else
      respond_with(resource)
    end
  end

  def reset_confirmation
     @email = params[:email]
  end

  protected
  def after_sending_reset_password_instructions_path_for(resource, resource_name)
    reset_confirmation_path(reset_password: true, email: resource.email)
  end
end
