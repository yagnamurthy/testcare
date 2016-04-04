class SubscribeToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    gibbon_client = Gibbon::API.new('750dd46c8ae03cd0573b843d12eb06fc-us7')
    gibbon_client.lists.subscribe(
      id: list_id(user),
      email: { email: user.email },
      merge_vars: {:FNAME => user.first_name},
      double_optin: false
    )
  end

  def list_id user
    if user.caregiver?
      '8bc143f9c0'
    elsif user.family?
      '18d99fb907'
    end
  end
end
