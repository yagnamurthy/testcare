class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :amount
      t.integer :hours
      t.date :start_date
      t.date :finish_date
      t.integer :status
      t.text :message
      t.integer :billing_type

      t.references :senders
      t.references :receivers
      t.timestamps
    end
  end
end
