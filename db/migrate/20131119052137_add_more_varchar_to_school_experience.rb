class AddMoreVarcharToSchoolExperience < ActiveRecord::Migration
  def change
  	change_column :schools, :name, :string, :limit => 80
  	change_column :experiences, :employer, :string, :limit => 80
  end
end
