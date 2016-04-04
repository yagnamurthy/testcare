module ElasticsearchHelper
  def to_miles_away obj, zipcode
    return miles_away_obj[obj.id] if miles_away_obj[obj.id]
    return 0 if obj.latitude.nil? || obj.longitude.nil?
    return 0 if zipcode.nil?

    geocoder_obj = Geocoder.search([obj.latitude, obj.longitude]).first
    to_geocoder_obj = Geocoder.search(zipcode).first

    lat_lng = [geocoder_obj.latitude, geocoder_obj.longitude]
    miles_away = Geocoder::Calculations.distance_between(
      [geocoder_obj.latitude, geocoder_obj.longitude],
      [to_geocoder_obj.latitude, to_geocoder_obj.longitude]
    )
    miles_away = miles_away.round
    miles_away = 1 if miles_away == 0

    miles_away_obj[obj.id] = miles_away

    return miles_away_obj[obj.id]
  end

  def miles_away_obj
    return @miles_away_obj if @miles_away_obj
    @miles_away_obj = {}
  end

  def miles_away_label obj, zipcode
    '(' + pluralize(to_miles_away(obj, zipcode), 'mile', 'miles') + ' away)'
  end

  def miles_away_label_mobile obj, zipcode
    pluralize(to_miles_away(obj, zipcode), 'mile', 'miles')
  end

  def miles_away_label_contract obj, zipcode
    pluralize(to_miles_away(obj, zipcode), 'mile', 'miles') + ' away'
  end
end
