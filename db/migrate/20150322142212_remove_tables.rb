class RemoveTables < ActiveRecord::Migration
  def up
    drop_table :accounts
    drop_table :affiliates
    drop_table :alerts
    drop_table :contacts
    drop_table :credit_cards
    drop_table :invoices
    drop_table :journals
    drop_table :screening_questions
  end

  def down
    create_table :accounts
    create_table :affiliates
    create_table :alerts
    create_table :contacts
    create_table :credit_cards
    create_table :invoices
    create_table :journals
    create_table :screening_questions
  end
end
