class ContractsServices < ActiveRecord::Migration
  def change
    create_table :contracts_services do |t|
    	t.references :contract
    	t.references :service
    end
  end
end
