class ChangeTypeToClassification < ActiveRecord::Migration
  def change
  	rename_column :services, :type, :classification
  end
end
