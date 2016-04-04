class ContractsRequirements < ActiveRecord::Migration
  def change
    create_table :contracts_requirements do |t|
    	t.references :contract
    	t.references :requirement
    end
  end
end
