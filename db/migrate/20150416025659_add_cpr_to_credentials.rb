class AddCprToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :CPR, :boolean, default: false
    add_column :credentials, :CPRNumber, :string, limit: 255
  end
end
