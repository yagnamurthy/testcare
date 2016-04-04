class LanguagesUsers < ActiveRecord::Migration
  def change
  	drop_table :languages_users

    create_table :languages_users do |t|
      t.references  :user
      t.string		:language_code, :limit => 2
    end
  end
end
