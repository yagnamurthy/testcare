class AddMd5hashToUser < ActiveRecord::Migration
  def change
  	add_column :users, :md5hash, :string
  end
end
