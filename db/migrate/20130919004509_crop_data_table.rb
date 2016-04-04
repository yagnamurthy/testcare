class CropDataTable < ActiveRecord::Migration
  def change
  	remove_column :users, :crop_x
  	remove_column :users, :crop_y
  	remove_column :users, :crop_h
  	remove_column :users, :crop_w
  end
end
