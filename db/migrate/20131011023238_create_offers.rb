class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :caregiver
      t.references :contract
      t.integer :rate, limit: 3
      t.integer :status, limit: 2
      t.timestamps
    end
  end
end
