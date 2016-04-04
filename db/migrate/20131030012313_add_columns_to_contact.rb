class AddColumnsToContact < ActiveRecord::Migration
  def change
  	drop_table :contacts
  	create_table :contacts

  	add_column :contacts, :name, :string
  	add_column :contacts, :title, :string
  	add_column :contacts, :company, :string
  	add_column :contacts, :email_home, :string
  	add_column :contacts, :email_work, :string
  	add_column :contacts, :phone_home, :string
  	add_column :contacts, :phone_work, :string
  	add_column :contacts, :phone_cell, :string
  	add_column :contacts, :fax, :string
  	add_column :contacts, :address, :string
  	add_column :contacts, :website, :string
  	add_column :contacts, :remarks, :text
  end
end
