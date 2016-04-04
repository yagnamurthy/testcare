class Region 
  include Tire::Model::Search
  extend ActiveModel::Naming
  include ActiveModel::Conversion  

  attr_accessor :zipcode, :city, :state, :lat_lng

  tire do
   mapping do
    indexes :zipcode, type: 'string'
    indexes :city, type: 'string'
    indexes :state, type: 'string'
    indexes :lat_lng, type: 'geo_point', lat_lon: true 
   end
  end
  
  def to_indexed_json
   {
       :id => self.id,
       :lat_lng => self.lat_lng,
       :city => self.city,
       :state => self.state
   }.to_json
  end


  def initialize attrs
    @zipcode = attrs[0]
    @city = attrs[1]
    @state = attrs[2]
    @lat_lng = attrs[3] + ", " + attrs[4]
  end
  

end