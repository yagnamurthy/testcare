class AddEducationAndWorkXpToUser < ActiveRecord::Migration
  def change
    add_column :users, :education, :text
    add_column :users, :work_experience, :text
  end
end
