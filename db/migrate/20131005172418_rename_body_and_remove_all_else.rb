class RenameBodyAndRemoveAllElse < ActiveRecord::Migration
  def change
  	rename_column :references, :comment, :body 
  	remove_column :references, :commentable_id
  	remove_column :references, :commentable_type
  	remove_column :references, :role 
  	remove_column :references, :rating
  	remove_column :references, :title

  	add_column :references, :caregiver_id, :integer
  	add_column :references, :relationship, :integer, :limit => 1
  end
end
