class AddHospiceFlagToUser < ActiveRecord::Migration
  def change
  	add_column :users, :hospice, :boolean, default: false
  end
end
