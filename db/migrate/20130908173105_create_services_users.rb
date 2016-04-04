class CreateServicesUsers < ActiveRecord::Migration
  def change
    create_table :services_users do |t|
    	t.references :services
    	t.references :user
    end
  end
end

