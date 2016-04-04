require 'spec_helper'
require "geo_data"

describe GeoData do

  context '#to_s' do
    it 'returns string of the current location is in the USA' do 
      @geo_data = GeoData.new('96.236.148.4')
      @geo_data.to_s.should eq('Pittsburgh, PA 15217')
    end

    it 'returns City, State, Zipcode when zipcode doesn\'t exist' do 
      @geo_data = GeoData.new('169.158.0.0')
      @geo_data.to_s.should eq('City or Zipcode')
    end
  end

  context '#to_zip' do 
    it 'returns string of zipcode when zipcode is in the USA' do 
      @geo_data = GeoData.new('96.236.148.4')
      @geo_data.to_zip.should eq('15217')
    end

    it 'returns a blank string when zipcode doesn\t exist' do 
      @geo_data = GeoData.new('169.158.0.0')
      @geo_data.to_zip.should eq('')
    end
  end
end
