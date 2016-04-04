class ChangeEpmloyerInExperienceToText < ActiveRecord::Migration
  def up
    change_column :experiences, :employer, :text
  end

  def down
    change_column :experiences, :employer, :string
  end
end
