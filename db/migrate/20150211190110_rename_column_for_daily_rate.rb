class RenameColumnForDailyRate < ActiveRecord::Migration
  def change
    rename_column :users, :daily_rate, :live_in_rate
  end
end
