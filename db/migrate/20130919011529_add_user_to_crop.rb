class AddUserToCrop < ActiveRecord::Migration
  def change
  	add_column :crop_data, :user_id, :integer
  end
end
