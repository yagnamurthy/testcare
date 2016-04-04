class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
    	t.references :user
      t.timestamps
    end
  end
end
