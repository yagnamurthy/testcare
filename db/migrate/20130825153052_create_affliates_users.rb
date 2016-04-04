class CreateAffliatesUsers < ActiveRecord::Migration
  def change
    create_table :affliates_users do |t|
    	t.references :affliate
        t.references :user
    end
  end
end
