class AddEditProfileModalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :edit_profile_modal, :boolean, :default => false
  end
end
