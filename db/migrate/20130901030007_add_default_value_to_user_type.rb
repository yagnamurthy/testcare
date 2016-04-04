class AddDefaultValueToUserType < ActiveRecord::Migration
	def up
	    change_column :users, :type, :string, :default => 'User'
	end

	def down
	    change_column :users, :type, :string, :default => nil
	end
end
