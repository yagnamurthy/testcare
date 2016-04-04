class OfferMailer < ActionMailer::Base
  default from: "team@carespotter.com"

  def offer_to_family family, caregiver, message, contract, offer
  	@family = family
  	@caregiver = caregiver
  	@message = message
  	@contract = contract
    @offer = offer

  	mail to: family.email, subject: "#{@caregiver.first_name} has applied for your care job"
  end

  def offer_to_caregiver caregiver, family, contract, message
  	@caregiver = caregiver
  	@family = family
  	@contract = contract
  	@message = message

  	mail to: @caregiver.email, subject: "#{@family.first_name}! has invited you to apply to their care job: #{@contract.headline}"
  end

  def caregiver_is_added_to_job caregiver, family, contract
  	@caregiver = caregiver
  	@family = family
  	@contract = contract

  	mail to: @caregiver.email, subject: "#{@family.first_name} has added you to their care account."
  end
end