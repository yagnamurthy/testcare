module MessagesHelper

	def mailbox_message_collapse_item index, total_messages
		(index == 0 || (index + 1) == total_messages) ? '' : 'hidden'
	end

	def show_read_message_hidden_link? mailbox_message_counter, total_message_count
		((mailbox_message_counter + 1) == total_message_count) && (total_message_count > 2)
	end

  def participant_name(conversation)
    conversation.receipts.reject { |p| p.receiver == current_user }.collect {|p| p.receiver.first_and_last_initial }.uniq.join("")
  end

  def participant_id(conversation)
    conversation.receipts.reject { |p| p.receiver == current_user }.collect {|p| p.receiver.id }.uniq.join("")
  end
end
