class ChangeMessageToBody < ActiveRecord::Migration
  def change
  	rename_column :messages, :message, :body
  end
end
