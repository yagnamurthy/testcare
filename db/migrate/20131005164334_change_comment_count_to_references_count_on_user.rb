class ChangeCommentCountToReferencesCountOnUser < ActiveRecord::Migration
  def change
  	rename_column :users, :comments_count, :references_count
  end
end
