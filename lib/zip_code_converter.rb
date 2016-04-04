require_dependency 'yaml'

class ZipCodeConverter

	attr_accessor :zipcode, :city, :state_abbr, :state, :latitude, :longitude

	PATH = File.join(File.dirname(__FILE__), 'states.yml')
	STATES = YAML::load_file(PATH)

	ZIPCODE_REGEX = /\d{5}/
	STATE_REGEX = /\s[a-zA-Z]{2}$|,\s[a-zA-Z]{2}$/

	def initialize(code, lat=nil, lng=nil)
    if lat && lng
		  calc_lat_lng_to_city_state lat, lng
    else
      calc_zipcode_city_state code.to_s
    end
	end

	private

  def calc_lat_lng_to_city_state lat, lng
    @city, @state = [lat, lng].to_region.split(', ')
    @zipcode = [lat, lng].to_zip
  end

	def calc_zipcode_city_state code
		code.match(ZIPCODE_REGEX) ?
			set_region_based_on_zipcode(code) :
				set_zipcode_based_on_region(code)
	end

	def set_region_based_on_zipcode code
		@zipcode = code.match(ZIPCODE_REGEX)[0]
		set_lat_lon
		set_region
	end

	def set_zipcode_based_on_region locale
		if STATE_REGEX =~ locale
			state = locale.match(STATE_REGEX)[0]
			locale.gsub!(STATE_REGEX, '')

			state.gsub!(/,/,'')

			@state = state.strip
			@city = locale.strip.capitalize
			@zipcode = "#{@city + ',' + @state}".to_zip[0]
			set_lat_lon
		elsif locale.split(',').length > 1
			locals = locale.split(',')

			@state = STATES[locals[1].strip.capitalize]
			@city = locals[0].strip.capitalize

			@zipcode = "#{@city + ',' + @state}".to_zip[0]
			set_lat_lon
		else
			@zipcode = locale.to_zip[0]
			set_region
		end

		if @state.length == 2
			@state = STATES[@state]
			@state_abbr = STATES[@state]
		else
			@state_abbr = STATES[@state]
			@state = STATES[@state_abbr]
		end

	end

	def set_lat_lon
		lat_lon = @zipcode.to_latlon.split(',')
		@latitude = lat_lon[0].strip
		@longitude = lat_lon[1].strip
	end

	def set_region
		region = @zipcode.to_region.split(',')

		@city = region[0].strip
		@state = region[1].strip

		if @state.length == 2
			@state = STATES[@state]
			@state_abbr = STATES[@state]
		else
			@state_abbr = STATES[@state]
			@state = STATES[@state_abbr]
		end
	end

end
