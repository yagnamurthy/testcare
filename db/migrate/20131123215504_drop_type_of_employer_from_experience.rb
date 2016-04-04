class DropTypeOfEmployerFromExperience < ActiveRecord::Migration
  def change
  	remove_column :experiences, :type
  	remove_column :experiences, :classification
  end
end
