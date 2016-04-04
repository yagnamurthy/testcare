require 'spec_helper'
require "#{Rails.root}/lib/zip_code_converter.rb"

describe ZipCodeConverter do

  context '#initialize' do
    it 'returns zipcode, city, state when city, state, zipcode was entered' do
      @converter = ZipCodeConverter.new('Winter Garden, Florida 34787')

      @converter.zipcode.should eq('34787')
      @converter.city.should eq('Winter Garden')
      @converter.state.should eq('Florida')
      @converter.state_abbr.should eq('FL')
      @converter.latitude.should eq('28.536794')
      @converter.longitude.should eq('-81.59344')
    end

    it 'returns zipcode, city, state when city, unabbrivated state was entered' do
      @converter = ZipCodeConverter.new('orlando, florida')

      @converter.zipcode.should eq('32801')
      @converter.city.should eq('Orlando')
      @converter.state.should eq('Florida')
      @converter.state_abbr.should eq('FL')
      @converter.latitude.should eq('28.541879')
      @converter.longitude.should eq('-81.37446')
    end

    it 'returns zipcode, city, state when zipcode was entered' do
      @converter = ZipCodeConverter.new('15217')

      @converter.zipcode.should eq('15217')
      @converter.city.should eq('Pittsburgh')
      @converter.state.should eq('Pennsylvania')
      @converter.state_abbr.should eq('PA')
      @converter.latitude.should eq('40.430919')
      @converter.longitude.should eq('-79.92569')
    end

    it 'returns zipcode, city, state when city was entered' do
      @converter = ZipCodeConverter.new('tampa')

      @converter.zipcode.should eq('33601')
      @converter.city.should eq('Tampa')
      @converter.state.should eq('Florida')
      @converter.state_abbr.should eq('FL')
    end

    it 'returns zipcode, city, state when city and state was entered' do
      @converter = ZipCodeConverter.new('Pittsburgh PA')

      @converter.zipcode.should eq('15201')
      @converter.city.should eq('Pittsburgh')
      @converter.state.should eq('Pennsylvania')
      @converter.state_abbr.should eq('PA')
    end

    it 'returns zipcode, city, state when city and state was entered with comma' do
      @converter = ZipCodeConverter.new('Pittsburgh, PA')

      @converter.zipcode.should eq('15201')
      @converter.city.should eq('Pittsburgh')
      @converter.state.should eq('Pennsylvania')
      @converter.state_abbr.should eq('PA')
    end
  end
end
