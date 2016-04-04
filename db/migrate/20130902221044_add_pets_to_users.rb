class AddPetsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :pets, :integer, :limit => 1
  end
end
