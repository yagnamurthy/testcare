class AddHourlyRateType < ActiveRecord::Migration
  def change
    add_column :contracts, :care_type, :string
    add_column :contracts, :hourly_type, :string
  end
end
