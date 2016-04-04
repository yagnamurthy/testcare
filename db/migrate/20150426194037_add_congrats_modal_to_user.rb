class AddCongratsModalToUser < ActiveRecord::Migration
  def change
    add_column :users, :congrats_modal, :boolean, default: false
  end
end
