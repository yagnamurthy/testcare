class ContractsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :show]
  around_action :can_view?, only: [:show]
  around_action :can_edit?, only: [:edit, :update]

  def index
    @contracts = Contract.search_by_lat_lng(params[:zipcode] || current_user.zipcode)
  end

  def search
    redirect_to contracts_path(lat: params[:lat], lng: params[:lng], address: params[:address], zipcode: params[:zipcode])
  end


  # Contracts controller only allows for
  # one contract per family group to be
  # created at one time
  def new
    @contract = current_contract
    redirect_to family_job_path
  end

  def edit
    @contract = current_contract
    redirect_to family_job_path
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def create
    if current_contract.update(contract_params)
      # since this isnt defined yet
      # we must set the user's zipcode / phone number
      current_user.update(
        zipcode: current_contract.zipcode,
        phone: current_contract.phone,
        has_been_edited: true
      )
      redirect_to family_shared_connections_path
    else
      render action: :new
    end
  end

  def update
    if current_contract.update(contract_params)
      redirect_to dashboard_path, notice: 'Your Job has been updated.'
    else
      render action: :edit
    end
  end

  def enable
    @contract = Contract.find(params[:id])

    @contract.indexable = true
    @contract.save!

    @contract.send_email_to_caregivers

    redirect_to admin_contracts_path, notice: "#{@contract.headline} was enabled!"
  end

  def disable
    @contract = Contract.find(params[:id])

    @contract.indexable = false
    @contract.save!

    Contract.index.remove @contract

    redirect_to admin_contracts_path, notice: "#{@contract.headline} was disabled!"
  end

  def destroy
    if @contract = Contract.find(params[:id])
      Contract.index.remove @contract

      if @contract.destroy
        redirect_to admin_contracts_path, notice: "#{@contract.headline} was deleted!"
      end
    end
  end

  private

    def can_view?
      @contract = Contract.find(params[:id])

      if current_user &&
        yield
      else
        session[:passthru_uri] = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
        redirect_to dashboard_path, notice: 'You cannot view this contract.'
      end
    end

    def can_edit?
      @contract = Contract.find(params[:id])

      if current_user && ( current_user.job.id == @contract.id )
        yield
      else
        redirect_to dasboard_path, notice: 'You cannot edit this contract'
      end
    end

    def contract_params
      params[:contract].permit(:patient_name, :headline, :description, :hours_needed, :zipcode, :phone, :job_type, :required_rate)
    end

    def current_contract
      @_current_contract ||= (current_user.current_contract || current_user.build_current_contract)
    end
end
