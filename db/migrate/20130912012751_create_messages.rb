class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message, :limit => 10000
      t.references :user
      t.timestamps
    end
  end
end
