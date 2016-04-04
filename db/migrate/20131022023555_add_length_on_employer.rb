class AddLengthOnEmployer < ActiveRecord::Migration
  def change
	change_column :experiences, :employer, :text  	
  end
end
