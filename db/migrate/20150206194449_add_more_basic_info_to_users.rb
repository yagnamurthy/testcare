class AddMoreBasicInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :live_in, :boolean
    add_column :users, :hometown, :text
  end
end
