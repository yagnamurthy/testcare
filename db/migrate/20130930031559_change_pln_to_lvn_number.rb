class ChangePlnToLvnNumber < ActiveRecord::Migration
  def change
  	rename_column :credentials, :LPNNumber, :LVNNumber
  end
end
