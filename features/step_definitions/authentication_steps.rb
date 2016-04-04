Given(/^I am an authenticated User$/) do
  @user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1', zipcode: 15217)
  login_as @user, scope: :user
end

Given(/^I am an authenticated Caregiver$/) do
  @caregiver = Caregiver.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1')
  login_as @caregiver, scope: :user
end

Given(/^I am an fully registered and authenticated Caregiver$/) do
  @caregiver = Caregiver.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1', gender: 1, hourly_rate: 15, bio: 'asdfasdfsd', work_experience: 15, zipcode: 15217)
  login_as @caregiver, scope: :user
end

Given(/^a caregiver is created$/) do
  @caregiver = Caregiver.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1', gender: 1, hourly_rate: 15, bio: 'asdfasdfsd', work_experience: 15, zipcode: 15217)
end
