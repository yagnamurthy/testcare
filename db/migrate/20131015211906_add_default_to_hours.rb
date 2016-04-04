class AddDefaultToHours < ActiveRecord::Migration
  def change
  	change_column_default :users, :hours, 0
  end
end
