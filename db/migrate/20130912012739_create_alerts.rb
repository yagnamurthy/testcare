class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string  :message
      t.boolean :private, :default => false
      t.timestamps
    end
  end
end
