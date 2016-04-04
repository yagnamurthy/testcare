class ReconfigureLanguage < ActiveRecord::Migration
  def change
  	drop_table :languages

  	create_table :languages, :id => false do |t|
      t.string		:name
      t.string      :code, :limit => 2, :null => false
    end   
    execute "ALTER TABLE languages ADD PRIMARY KEY (code);" 
  end
end