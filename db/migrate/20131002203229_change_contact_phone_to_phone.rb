class ChangeContactPhoneToPhone < ActiveRecord::Migration
  def change
  	rename_column :users, :contact_phone, :phone
  end
end
