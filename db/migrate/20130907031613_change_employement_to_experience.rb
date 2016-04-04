class ChangeEmployementToExperience < ActiveRecord::Migration
  def change
  	rename_table :employments, :experiences
  end
end
