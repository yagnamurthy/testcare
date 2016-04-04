class CreateMailReceipts < ActiveRecord::Migration
  def change
    create_table :mail_receipts do |t|
      t.references :user
      t.references :message
      t.references :recipient
      t.boolean :read, :default => false
      t.timestamps
    end
  end
end
