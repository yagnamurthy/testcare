class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :filename
      t.string :format
      t.integer :size
      t.references :user
      t.timestamps
    end
  end
end
