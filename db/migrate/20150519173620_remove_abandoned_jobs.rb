class RemoveAbandonedJobs < ActiveRecord::Migration
  def up
    contracts = Contract.all
    contracts.each do |contract|
      owner = contract.owner

      if owner.nil?
        Contract.index.remove contract
        contract.destroy
      end
    end
  end
end
