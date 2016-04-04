class AddVerifiedToAccount < ActiveRecord::Migration
  def change
  	add_column :accounts, :verify, :boolean, :default => false
  end
end
