class CreateCareTypes < ActiveRecord::Migration
  def change
    create_table :care_types do |t|
      t.string      :name
      t.timestamps
    end

    remove_column :contracts, :care_type, :string
  end
end
