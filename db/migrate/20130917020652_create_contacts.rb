class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.string :full_name
    	t.string :reference_name
    	t.string :company_name
    	t.string :description
    	t.string :email
    	t.string :email_work
    	t.string :phone
    	t.string :phone_work
    	t.references :user
      t.timestamps
    end
  end
end
