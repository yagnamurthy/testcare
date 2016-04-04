class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.text :body
      t.datetime :entry_date
      t.references :user
      t.timestamps
    end
  end
end
