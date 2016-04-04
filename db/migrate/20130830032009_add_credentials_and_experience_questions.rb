class AddCredentialsAndExperienceQuestions < ActiveRecord::Migration
  def change
  	add_column :users, :credientials, :text
  	add_column :users, :nursing_license_number, :string
  	add_column :users, :type_of_employer, :string
  	add_column :users, :employer, :string
  end
end
