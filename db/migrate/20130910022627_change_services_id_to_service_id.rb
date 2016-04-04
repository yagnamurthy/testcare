class ChangeServicesIdToServiceId < ActiveRecord::Migration
  def change
  	rename_column :services_users, :services_id, :service_id
  end
end
