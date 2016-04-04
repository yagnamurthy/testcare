class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string 			:url
      t.string			:verifications_uri
      t.string			:account_number
      t.string			:bank_name
      t.timestamps
    end
  end
end