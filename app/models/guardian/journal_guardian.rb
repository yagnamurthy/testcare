module JournalGuardian

	def can_see_journal? instance
		ensure_authorized!
		@current_user.contract_ids.include?(instance.contract_id)
	end

	def can_edit_journal?
		ensure_authorized!
	end

	private 

	def assoicated_contract 
		@current_user.contract_ids
	end

end