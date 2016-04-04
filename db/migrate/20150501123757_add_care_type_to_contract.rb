class AddCareTypeToContract < ActiveRecord::Migration
  def up
    add_column :contracts, :care_type, :integer

    Contract.all.each do |contract|
      contract.care_type = 1
      contract.save!(validate: false)
    end
  end

  def down
    remove_column :contracts, :care_type
  end
end
