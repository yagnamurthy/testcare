class AddOtherToCredential < ActiveRecord::Migration
  def change
  	add_column :credentials, :other, :boolean, :default => false
  end
end
