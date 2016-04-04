class AddContractTypeToOffer < ActiveRecord::Migration
  def change
  	add_column :offers, :contract_type, :integer, :limit => 2
  end
end
