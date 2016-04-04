class AddLangToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :language, :integer
  end
end
