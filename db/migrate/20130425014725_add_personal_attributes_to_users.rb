class AddPersonalAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :integer

    add_column :users, :bio, :text
    add_column :users, :headline, :string
    add_column :users, :hours, :string

    add_column :users, :experience, :integer
    add_column :users, :availability, :integer
    add_column :users, :education_level, :integer

    add_column :users, :insured, :boolean
    add_column :users, :bonded, :boolean
    add_column :users, :background_checked, :boolean
    add_column :users, :reviewed, :boolean

  end
end
