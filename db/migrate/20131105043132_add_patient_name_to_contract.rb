class AddPatientNameToContract < ActiveRecord::Migration
  def change
  	add_column :contracts, :patient_name, :string
  end
end
