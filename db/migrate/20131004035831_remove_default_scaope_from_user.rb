class RemoveDefaultScaopeFromUser < ActiveRecord::Migration
  def change
  	change_column_default :users, :smokes, nil
  end
end
