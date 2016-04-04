module ApplicationHelper
	def uniq_page_id controller
		"#{controller.controller_name}-#{controller.action_name}"
	end

	def extended_class controller
		controller.controller_name != 'web' ? "extended #{controller.controller_name}" : ''
	end

	def resource_name
	    :user
	end

	def resource
		@resource ||= User.new
	end

	def resource_class
		User
	end

	def devise_mapping
	    @devise_mapping ||= Devise.mappings[:user]
	end

    def augment_the_dollar_amounts rate
      if rate
        "#{rate - 2}-#{rate + 2}"
      else
        'N/A'
      end
    end

    def abbr_time duration
        if duration == 'Hour'
            return 'hr'
        elsif duration == 'Day'
            return 'day'
        elsif duration == 'Minute'
            return 'min'
        end
    end
end
