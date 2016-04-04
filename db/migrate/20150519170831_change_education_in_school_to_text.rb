class ChangeEducationInSchoolToText < ActiveRecord::Migration
  def up
    change_column :schools, :name, :text
  end

  def down
    change_column :schools, :name, :string
  end
end
