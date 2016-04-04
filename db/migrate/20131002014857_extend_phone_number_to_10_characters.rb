class ExtendPhoneNumberTo10Characters < ActiveRecord::Migration
  def change
  	change_column :users, :contact_phone, :bigint, :limit => 10
  end
end
