class AddContractIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :contract_id, :integer
  end
end
