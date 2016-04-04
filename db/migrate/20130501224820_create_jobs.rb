class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string      :headline
      t.string      :body
      t.references  :user

      t.timestamps
    end
  end
end
