class AddIndexableToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :indexable, :boolean, :default => false
  end
end
