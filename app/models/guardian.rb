require_dependency 'permission_error'
require_dependency 'guardian/journal_guardian'

class Guardian

	include JournalGuardian

	def initialize user=nil 
		@current_user = user || Guest.new()
	end

	def authorized?
		@current_user.present?
	end

	def ensure_caregiver! 
		raise PermissionError, 'Must be caregiver to view' unless @current_user.caregiver?
		true
	end

	def ensure_family!
		raise PermissionError, 'Must be family to view' unless @current_user.family?
		true
	end

	def ensure_admin!
		raise PermissionError, 'Must be admin to view' unless @current_user.admin?
		true
	end

	def ensure_authorized!
		raise PermissionError, 'Must be logged in to view' unless authorized?
		true
	end

	def can? action=nil, instance=nil
		raise ArgumentError if action.nil? or instance.nil?
		send(:"can_#{action}_#{instance.class.name.downcase}", instance)
	end

end