class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
    	t.string     :company, :limit => 30
    	t.date 	     :start_date
    	t.date 	     :finish_date
    	
    	t.references :user
    end
  end
end
