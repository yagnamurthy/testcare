class AddConversationIdToOffer < ActiveRecord::Migration
  def change
  	add_column :offers, :conversation_id, :integer
  end
end
