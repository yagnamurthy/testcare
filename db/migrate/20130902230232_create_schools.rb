class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
    	t.string     :name, :limit => 30
    	t.date 	     :start_date
    	t.date 	     :finish_date
    	t.integer    :degree, :limit => 1
    	t.references :user
    end
  end
end
