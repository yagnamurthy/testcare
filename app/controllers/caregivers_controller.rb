require_dependency 'geo_data'

class CaregiversController < UsersController

  before_action :set_caregiver, only: [ :show, :edit, :update, :destroy ]

  def index
    respond_to do |format|
      format.csv { send_data Caregiver.to_csv }
    end
  end

  def show
    @caregiver = @caregiver.decorate
  end

  def near
    @search_engine = Caregiver::Search.new(params)
    @caregivers = @search_engine.search
  end

  def state_and_city_near
    city = params[:city].gsub(' ', '').gsub('-', ' ')
    state = params[:state]
    region = "#{city}, #{state}"

    @region = Geocoder.search(region).first

    if @region && @region.formatted_address
      zipcode = @region.formatted_address.gsub(', USA', '').to_zip.first
      @caregivers = Caregiver.where(zipcode: zipcode, indexable: true).order("updated_at DESC").limit(10)
      @count = @caregivers.length
      @averages = Caregiver.get_averages @caregivers

      @title = "#{@region.city} Senior Caregivers - $#{@averages.hourly_rate.round}/hr & Up"
      @description = "Choose from #{@caregivers.length} caregivers near #{@region.city}, #{@region.state}. CareSpotter helps families find the perfect #{@region.city} Senior Caregivers for your loved ones."
    else
      respond_with status: 404
    end
  end

  def search
    region = Geocoder.search(zipcode_params).first

    begin
      redirect_to near_path({
        zipcode: region.city.downcase,
        s: params[:s],
        page: params[:page]
      })
    rescue
      redirect_to error_404_path
    end
  end

  def destroy
    if @caregiver = Caregiver.find(params[:id])
      Caregiver.index.remove @caregiver

      if @caregiver.destroy
        redirect_to admin_caregivers_path, notice: "#{@caregiver.full_name} was deleted!"
      end
    end
  end

  private

  def set_caregiver
    @caregiver = Caregiver.find(params[:id])
  end

  def zipcode_params
    if !params[:zipcode].blank?
      Geocoder.coordinates(params[:zipcode])
    elsif params[:s] && !params[:s][:zipcode].blank?
      Geocoder.coordinates(params[:s][:zipcode])
    else
      zipcode = GeoData.new(request.remote_ip).to_zip
      Geocoder.coordinates(zipcode)
    end
  end

end
