class RequestedReferences < ActiveRecord::Migration
  def change
     create_table :requested_references do |t|
      t.text    :name
      t.text    :phone
      t.text    :email
      t.references :caregiver
    end
  end
end

