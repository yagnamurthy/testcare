class ChangeContractsUsers < ActiveRecord::Migration
  def change
  	rename_column :contracts_users, :user_id, :caregiver_id 
  	rename_column :contracts_users, :contracts_id, :contract_id
  end
end
