class AddIndexableToUser < ActiveRecord::Migration
  def change
  	add_column :users, :indexable, :boolean, :default => false
  end
end
