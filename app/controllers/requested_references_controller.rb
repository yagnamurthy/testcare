class RequestedReferencesController < ApplicationController

  def request_references
    @reference = RequestedReference.new
  end

  def create
    @caregiver = current_user
    @reference = RequestedReference.new(request_reference_params.merge(caregiver_id: current_user.id))
    if @reference.save!
      redirect_to dashboard_path, notice: "Reference successfully created."
    else
      redirect_to dashboard_path, notice: 'Reference unsuccessfully created'
    end
  end

  private

  def request_reference_params
    params[:requested_reference].permit(:name, :email, :phone)
  end
end

