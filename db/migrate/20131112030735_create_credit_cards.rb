class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
    	t.string 	:brand
    	t.string	:expiration_month
    	t.string	:expiration_year
    	t.string	:hash_value
    	t.boolean	:is_valid
    	t.boolean	:is_verified
    	t.string	:last_four
    	t.string	:uri
    	t.references :user
    	
      	t.timestamps
    end
  end
end
