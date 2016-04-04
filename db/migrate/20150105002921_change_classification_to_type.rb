class ChangeClassificationToType < ActiveRecord::Migration
  def change
    rename_column :services, :classification, :type
  end
end
