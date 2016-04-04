require 'ostruct'
require 'spec_helper'
require "#{Rails.root}/lib/facebook.rb"

describe Facebook do

  before(:each) do
      @info = OpenStruct.new({ first_name: 'kyle', last_name: 'szives' })
      @data = OpenStruct.new({ birthday: '10/07/1988', location: OpenStruct.new({ name: 'Pittsburgh, Pennslvania' }) })
  end

  context '#find_or_create_instance' do
    it 'returns a caregiver when a facebook record is found' do
      @data.email = 'fbtest@gmail.com'
      @data.id = rand(10000..99999)

      user = Caregiver.create!({first_name: 'Kyle', last_name: 'Szives', password: 'asdfasdf1', facebook_id: @data.id, email: @data.email})
      Facebook.find_or_create_instance(@info, @data, Caregiver).id.should eq(user.id)
    end

    it 'returns a caregiver when facebook record is not found' do
      @data.email = 'fbtest2@gmail.com'
      @data.id = rand(10000..99999)

      Facebook.find_or_create_instance(@info, @data, Caregiver).first_name.should eq('kyle')
    end

    it 'returns a caregiver when the email has a match but not an id' do
      @data.email = 'fbtest3@gmail.com'
      @data.id = rand(10000..99999)
      
      user = Caregiver.create!({first_name: 'Kyle', last_name: 'Szives', password: 'asdfasdf1', email: @data.email})
      Facebook.find_or_create_instance(@info, @data, Caregiver).facebook_id.should eq(@data.id)
    end
  end

  context '#find_or_create_instance' do
    it 'returns a user when a facebook record is found' do
      @data.email = 'fbtest@gmail.com'
      @data.id = rand(10000..99999)

      user = User.create!({first_name: 'Kyle', last_name: 'Szives', password: 'asdfasdf1', facebook_id: @data.id, email: @data.email})
      Facebook.find_or_create_instance(@info, @data, User).id.should eq(user.id)
    end

    it 'returns a caregiver when facebook record is not found' do
      @data.email = 'fbtest2@gmail.com'
      @data.id = rand(10000..99999)

      Facebook.find_or_create_instance(@info, @data, User).first_name.should eq('kyle')
    end

    it 'returns a caregiver when the email has a match but not an id' do
      @data.email = 'fbtest3@gmail.com'
      @data.id = rand(10000..99999)
      
      user = User.create!({first_name: 'Kyle', last_name: 'Szives', password: 'asdfasdf1', email: @data.email})
      Facebook.find_or_create_instance(@info, @data, User).facebook_id.should eq(@data.id)
    end
  end
end
