class ChangeCurrentToBoolean < ActiveRecord::Migration
  def change
  	remove_column :experiences, :current 
  	add_column :experiences, :current, :boolean
  end
end
