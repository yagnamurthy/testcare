class CreateCropData < ActiveRecord::Migration
  def change
    create_table :crop_data do |t|
    	t.integer :crop_x, :limit => 4
    	t.integer :crop_y, :limit => 4
    	t.integer :crop_w, :limit => 4
    	t.integer :crop_h, :limit => 4
    end
  end
end
