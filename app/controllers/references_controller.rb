class ReferencesController < ApplicationController

  def give_references
    @reference = Reference.new(params[:caregiver_id])
  end

  def create
    @caregiver = Caregiver.find(params[:caregiver_id] || reference_params[:caregiver_id])
    @reference = Reference.new(reference_params.merge(caregiver_id: params[:caregiver_id]))

    if current_user && current_user.id
      @reference.user_id = current_user.id
    end

    if @reference.save!
      redirect_to caregiver_path(params[:caregiver_id]), notice: "Reference successfully created."
    else
      redirect_to caregiver_path(params[:caregiver_id]), notice: 'Reference unsuccessfully created'
    end
  end

  private

  def reference_params
    params[:reference].permit(:body, :name, :caregiver_id,
                              :dependability, :communication_skills,
                              :compassion, :technical_ability)
  end
end
