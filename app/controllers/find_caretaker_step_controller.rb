class FindCaretakerStepController < ApplicationController

  def index
  end

  def get_started
    @contract = Contract.new(patient_name: params[:patient_name], city: params[:city])

    if @contract.save
      redirect_to "/find_caretaker_step/caregivers?id=#{@contract.id}"
    end
  end

  def caregivers
    @contract = Contract.find(params[:id])
  end

  def care_needs
    @contract = Contract.find(params[:id])
  end

  def schedule
    @contract = Contract.find(params[:id])
  end

  def caretaker
    @contract  = Contract.find(params[:id])
    @languages = Language.all

  end

  def submit
    @contract = Contract.find(params[:id])
  end

  def update

    @contract = Contract.find(params[:id])
    @contract.update_attributes contracts_params

    if params[:care_types].present?
      @care_types = params[:care_types].split(',')
      @care_types.each do |ctype|
        @contract.care_types.create(name: ctype)
      end
    end

    if params[:schedule_time].present?
      @schedule_days = params[:schedule_time].split(',')
      @schedule      = @contract.schedules.first_or_create

      @schedule_days.each do |sd|
        @schedule.update_attribute "#{sd.underscore}", true
      end
    end

    redirect_to action: params[:next_step], id: @contract.id
  end

  def search
    @result = Geocoder.search(params[:query])
    @search = @result[0].address_components

    respond_to do |format|
      format.json { render json: { search: @search}}
      format.html { render layout: false }
    end
  end

  protected

  def contracts_params
    params.permit(:owner_id, :headline, :description, :hours_needed, :job_type, :time_of_care, :language, :days_of_care,
                                   :schedule_type, :required_rate, :city, :patient_name, :care_type, :expected_date)
  end
end
