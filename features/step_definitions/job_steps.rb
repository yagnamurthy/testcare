Given(/^I have a job posting$/) do
  user = User.last
  Contract.create!({
    owner_id: user.id,
    headline: 'This is a headline',
    description: 'This is a description',
    hours_needed: 1,
    job_type: 1,
    required_rate: 12,
    zipcode: 15217,
    patient_name: 'Sam',
    phone: 5555555555
  })
end

Given(/^there are jobs to apply to$/) do
  Contract.index.delete
  Contract.create_elasticsearch_index

  @user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1')
  Contract.create!({
    owner_id: @user.id,
    headline: 'This is a headline',
    description: 'This is a description',
    hours_needed: 1,
    job_type: 1,
    required_rate: 12,
    zipcode: 15217,
    patient_name: 'Sam',
    phone: 5555555555
  })

  @user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1')
  Contract.create!({
    owner_id: @user.id,
    headline: 'This is a headline',
    description: 'This is a description',
    hours_needed: 1,
    job_type: 1,
    required_rate: 12,
    zipcode: 15217,
    patient_name: 'Sam',
    phone: 5555555555
  })

  Contract.import
  Contract.index.refresh
end

When(/^I fill out the message form$/) do
  fill_in 'message', with: 'This is a message'
  fill_in 'rate', with: '15'
end



When(/^there are caregivers in their zipcode$/) do 
  
    Caregiver.create({
      first_name: 'asdf', 
      last_name: 'asdf', 
      email: Faker::Internet.email, 
      password: 'somethingelse1', 
      zipcode: '15217', 
      hourly_rate: '20', 
      last_sign_in_at: DateTime.now,
      indexable: true
    })

    Caregiver.import
    Caregiver.index.refresh
end

When(/^I fill out the offer with$/) do |table|
  rows = table.rows_hash

  choose rows['Contract Type']
  fill_in 'offer[rate]', with: rows['Rate']
  fill_in 'offer[message][body]', with: rows['Message']

end

When(/^I check the TOS$/) do
  check "I understand and agree to the Carespotter user agreement and incorporated policies."
end

When(/^I shouldnt see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end