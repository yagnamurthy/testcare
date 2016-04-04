class ChangeExperienceColumnToYearsExperience < ActiveRecord::Migration
  def change
  	remove_column :users, :work_experience
  	rename_column :users, :experience, :work_experience
  end
end
