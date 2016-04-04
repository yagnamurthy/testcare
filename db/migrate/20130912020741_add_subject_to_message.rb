class AddSubjectToMessage < ActiveRecord::Migration
  def change
  	add_column :messages, :subject, :string
  	add_column :messages, :read, :boolean, :defualt => 0
  end
end
