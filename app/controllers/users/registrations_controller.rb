class Users::RegistrationsController < Devise::RegistrationsController
	def new
		@user = params[:type] == "Caregiver" ? Caregiver.new : User.new
		render '/users/registrations/get_started'
		# params[:modal] ? render('/users/registrations/get_started_modal') : render('/users/registrations/get_started')
	end
end
