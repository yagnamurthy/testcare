class AddCarrierToUser < ActiveRecord::Migration
  def change
    add_column :users, :carrier, :string
  end
end
