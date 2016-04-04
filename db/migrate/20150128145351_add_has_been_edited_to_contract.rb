class AddHasBeenEditedToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :has_been_edited, :boolean, default: false

    Contract.all.each do |c|
        c.has_been_edited=true
        c.save!(validate: false)
    end
  end
end
