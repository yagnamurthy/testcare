class ChangeUserToOwnerForContract < ActiveRecord::Migration
  def change
  	rename_column :contracts, :user_id, :owner_id
  end
end
