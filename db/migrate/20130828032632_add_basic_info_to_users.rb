class AddBasicInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :contact_phone, :integer
  	add_column :users, :english_proficiency, :integer
  	add_column :users, :transportation, :integer
  	add_column :users, :smokes, :boolean
  	add_column :users, :allergies, :boolean
  end
end
