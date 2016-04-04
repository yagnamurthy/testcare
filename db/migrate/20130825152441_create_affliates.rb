class CreateAffliates < ActiveRecord::Migration
  def change
    create_table :affliates do |t|
      t.string :name
      t.timestamps
    end
  end
end
