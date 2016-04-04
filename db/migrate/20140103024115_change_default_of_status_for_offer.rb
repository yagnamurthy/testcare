class ChangeDefaultOfStatusForOffer < ActiveRecord::Migration
  def change
  	change_column :offers, :status, :integer, default: 1
  end
end
