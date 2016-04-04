class AddColumnForUserDailyRate < ActiveRecord::Migration
  def change
    add_column :users, :daily_rate, :integer
  end
end
