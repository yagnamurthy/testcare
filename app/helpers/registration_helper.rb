module RegistrationHelper

	def greater_than current, selected
		sidebar_array = [
			'basics', 
			'about', 
			'availability_and_services', 
			'education_and_experience']

		if sidebar_array.index(current) > sidebar_array.index(selected)
			'disabled'
		else
			''
		end
	end

end
