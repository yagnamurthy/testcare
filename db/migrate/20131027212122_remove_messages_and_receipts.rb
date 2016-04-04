class RemoveMessagesAndReceipts < ActiveRecord::Migration
  def change
  	drop_table :messages 
  	drop_table :mail_receipts
  end
end
