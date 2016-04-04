class AddNameToReference < ActiveRecord::Migration
  def change
  	add_column :references, :name, :string
  end
end
