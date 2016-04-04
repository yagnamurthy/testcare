class CreateLanguagesUsers < ActiveRecord::Migration
  def change
    create_table :languages_users do |t|
    	t.references :languages
        t.references :user
    end
  end
end
