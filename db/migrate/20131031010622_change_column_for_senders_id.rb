class ChangeColumnForSendersId < ActiveRecord::Migration
  def change
  	rename_column :invoices, :senders_id, :sender_id 
  	rename_column :invoices, :receivers_id, :receiver_id
  end
end
