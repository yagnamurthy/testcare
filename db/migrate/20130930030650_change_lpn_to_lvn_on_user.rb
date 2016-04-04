class ChangeLpnToLvnOnUser < ActiveRecord::Migration
  def change
  	rename_column :credentials, :LPN, :LVN
  end
end
