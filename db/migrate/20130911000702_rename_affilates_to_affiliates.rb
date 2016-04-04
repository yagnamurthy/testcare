class RenameAffilatesToAffiliates < ActiveRecord::Migration
  def change
  	rename_table :affliates, :affiliates
  	rename_table :affliates_users, :affiliates_users

  	rename_column :affiliates_users, :affliate_id, :affiliate_id
  end
end
