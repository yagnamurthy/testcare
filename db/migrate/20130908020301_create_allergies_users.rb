class CreateAllergiesUsers < ActiveRecord::Migration
  def change
    create_table :allergies_users do |t|
    	t.references :allergy
    	t.references :user
    end
  end
end
