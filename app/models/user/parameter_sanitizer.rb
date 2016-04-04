class User::ParameterSanitizer < Devise::ParameterSanitizer

  private
  def sign_up
    default_params.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :city, :type, :contract_id)
  end
end
