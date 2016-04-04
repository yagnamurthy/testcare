class AddMoreFieldsToJob < ActiveRecord::Migration
  def change
    add_column :contracts, :schedule_type, :integer
    add_column :contracts, :schedule_need, :boolean
    add_column :contracts, :gender, :integer
    add_column :contracts, :age_range, :integer
  end
end
