class AddPendingToAffiliate < ActiveRecord::Migration
  def change
  	add_column :affiliates, :pending, :boolean, :default => true
  end
end
