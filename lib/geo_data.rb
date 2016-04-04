require 'geoip'

class GeoData

  def initialize ip
    @geo = GeoIP.new('lib/GeoLiteCity.dat')
    @ip = ip
    @geo_ip_data = @geo.city(ip)

    @geo_ip_data
  end

  def to_s
      if @geo_ip_data && !@geo_ip_data.city_name.blank? && !@geo_ip_data.region_name.blank? && !@geo_ip_data.postal_code.blank?
        "#{@geo_ip_data.city_name}, #{@geo_ip_data.region_name} #{@geo_ip_data.postal_code}"
      else
        'City or Zipcode'
      end
  end

  def to_zip
    if @geo_ip_data && !@geo_ip_data.postal_code.blank?
      "#{@geo_ip_data.postal_code}"
    else
      ''
    end
  end
end