class RemoveUnusedUserColumns < ActiveRecord::Migration
  def change
  	remove_column :users, :education_level
  	remove_column :users, :rating
  	remove_column :users, :education 
  	remove_column :users, :english_proficiency
  	remove_column :users, :allergies
  	remove_column :users, :credientials
  	remove_column :users, :nursing_license_number
  	remove_column :users, :type_of_employer

  	change_column_default :users, :hours, default: 0

  end
end
