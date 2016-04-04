class ChangeCommentToReferences < ActiveRecord::Migration
  def change
  	rename_table :comments, :references
  end
end
