class DropSmokesToHeroku < ActiveRecord::Migration
  def change
  	remove_column :users, :smokes 
  	add_column :users, :smokes, :integer, :limit => 1, :default => 3
  end
end
