class ContractsUsers < ActiveRecord::Migration
  create_table :contracts_users do |t|
    t.references  :user
    t.references	:contracts
  end
end
