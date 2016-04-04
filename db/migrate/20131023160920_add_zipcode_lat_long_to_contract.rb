class AddZipcodeLatLongToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :latitude, :float
    add_column :contracts, :longitude, :float
    add_column :contracts, :zipcode, :integer
  end
end
