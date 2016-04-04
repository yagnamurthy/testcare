class AddTimeToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :expected_date, :date
    add_column :contracts, :days_of_care, :integer
    add_column :contracts, :time_of_care, :integer
  end
end
