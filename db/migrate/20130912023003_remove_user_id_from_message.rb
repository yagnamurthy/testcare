class RemoveUserIdFromMessage < ActiveRecord::Migration
  def change
  	remove_column :messages, :user_id
  	remove_column :messages, :read
  end
end
