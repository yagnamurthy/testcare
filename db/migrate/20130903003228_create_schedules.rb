class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
    	t.integer :day, :limit => 1
    	t.integer :time, :limit => 1
    	t.boolean :available, :default => false
    	t.references :user
    end
  end
end
