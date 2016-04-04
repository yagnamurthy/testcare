class ContractCareType < ActiveRecord::Migration
  def change
    create_table :care_types_contracts do |t|
        t.references :care_type
        t.references :contract
    end
  end
end
