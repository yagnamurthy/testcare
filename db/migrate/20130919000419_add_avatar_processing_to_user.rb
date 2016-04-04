class AddAvatarProcessingToUser < ActiveRecord::Migration
	def self.up
	  add_column :users, :avatar_processing, :boolean
	end

	def self.down
	  remove_column :users, :avatar_processing
	end
end