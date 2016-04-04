class ChangeZipcodeInContracTToString < ActiveRecord::Migration
  def change
  	change_column :contracts, :phone, :string
  	change_column :contracts, :zipcode, :string
  end
end
