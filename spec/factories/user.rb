require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    id 10000
    email 'john.doe@example.com'
    password 'password1'
  end
end