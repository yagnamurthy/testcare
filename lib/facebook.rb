class Facebook

	def self.find_or_create_instance auth_data, klass
		info = auth_data.info
		user_data = auth_data.extra.raw_info
		@klass = (klass.blank? || klass.nil?) ? User : klass.constantize

		user = find_user(user_data.id) || find_user_by_email(user_data.email, user_data.id)

		if user.nil?
			user = create!(info, user_data)
		end

		user
	end

	private 
	# 
	# Since this returns a user, the user can login via facebook
	def self.find_user facebook_id
		@klass.where(facebook_id: facebook_id).first
	end

	#
	# Since this returns false, the controller must determine what to do
	# Suggest to link account
	def self.find_user_by_email email, facebook_id
		user = @klass.where(email: email).first

		if user.nil?
			user = nil
		else
			user.facebook_id = facebook_id
			user.save!
		end

		user
	end

	#
	# Creates the user based on the facebook data
	def self.create! info, user_data
		params = {
			first_name: info.first_name,
	        last_name: info.last_name,
	        email: user_data.email,
	        date_of_birth: user_data.birthday,
	        gender: user_data.gender === 'male' ? 1 : 2,
	        facebook_id: user_data.id,
	        password: Devise.friendly_token[0,18] + "1A"
		}

		if user_data.location && user_data.location.name
			location = user_data.location.name.split(',')

			params['city'] = location[0]
			params['state'] = location[1]
		end

		@klass.create!(params)
	end
end