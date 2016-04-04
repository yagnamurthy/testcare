class ContractAdditionalFields < ActiveRecord::Migration
  def change
  	add_column :contracts, :headline, :string
  	add_column :contracts, :description, :text
  	add_column :contracts, :hours_needed, :integer, :limit => 3
  	add_column :contracts, :job_type, :integer, :limit => 1
  	add_column :contracts, :required_rate, :integer, :limit => 3
  end
end