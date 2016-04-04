class AddContractToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :contract_id, :integer
  end
end
