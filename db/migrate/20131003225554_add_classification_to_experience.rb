class AddClassificationToExperience < ActiveRecord::Migration
  def change
  	add_column :experiences, :classification, :integer, :limit =>1
  end
end
