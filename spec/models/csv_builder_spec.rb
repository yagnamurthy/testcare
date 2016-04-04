require 'spec_helper'

describe CSVBuilder do
  context '#generate' do 

    before(:each) do 
      10.times do
        Caregiver.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 'password1')
      end
    end

    it 'returns a csv string for all of a specific class' do 
      @csv_builder = CSVBuilder.new(Caregiver.all)
      @csv_builder.generate
    end
  end
end
