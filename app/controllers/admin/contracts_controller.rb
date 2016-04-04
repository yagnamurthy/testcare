class Admin::ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!
  before_action :set_job

  def edit
  end

  def update
    puts contract_params.inspect

    if @job.update(contract_params)
      redirect_to admin_contracts_path, notice: "You successfully updated #{@job.headline}"
    else
      render action: 'edit'
    end
  end

  private

  def set_job
    @job = Contract.find(params[:id])
  end

  def contract_params
    params[:contract].permit(
      :headline, :description, :hours_needed,
      :job_type, :required_rate, :zipcode, :patient_name,
      :phone, requirement_ids: [], service_ids: []
    )
  end
end
