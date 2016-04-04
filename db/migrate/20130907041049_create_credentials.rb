class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|

    	t.boolean		 :HHA, :default => false
    	t.boolean		 :LPN, :default => false
    	t.boolean		 :CNA, :default => false
    	t.boolean		 :RN, :default => false

    	t.string		 :HHANumber
    	t.string		 :LPNNumber
    	t.string		 :CNANumber
    	t.string		 :RNNumber

    	t.references :user

      t.timestamps
    end
  end
end
