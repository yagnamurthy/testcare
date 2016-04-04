class ChangeDateFormatOfSchools < ActiveRecord::Migration
  def change
  	remove_column :schools , :start_date 
  	remove_column :schools, :finish_date

  	add_column :schools, :start_date_year, :integer
  	add_column :schools, :finish_date_year, :integer

  end
end
