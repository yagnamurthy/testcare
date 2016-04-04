class AddAdditionalFieldsToExperience < ActiveRecord::Migration
  def change
  	add_column :experiences, :type, :integer, :limit => 1
  	add_column :experiences, :current, :integer, :limit => 1
  	add_column :experiences, :description, :text
  	add_column :experiences, :position, :string

  	rename_column :experiences, :company, :employer
  end
end
