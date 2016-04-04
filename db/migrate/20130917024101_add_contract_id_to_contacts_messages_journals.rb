class AddContractIdToContactsMessagesJournals < ActiveRecord::Migration
  def change
  	add_column :journals, :contract_id, :integer
  	add_column :mail_receipts, :contract_id, :integer
  	add_column :contacts, :contract_id, :integer
  end
end
