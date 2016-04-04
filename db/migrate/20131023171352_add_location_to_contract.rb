class AddLocationToContract < ActiveRecord::Migration
  def change
  	add_column :contracts, :city, :string
  	add_column :contracts, :state, :string
  end
end
