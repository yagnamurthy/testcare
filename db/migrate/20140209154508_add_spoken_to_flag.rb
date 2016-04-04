class AddSpokenToFlag < ActiveRecord::Migration
  def change
  	add_column :users, :contacted, :boolean, default: false
  end
end
