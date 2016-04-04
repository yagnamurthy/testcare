class UpdateCaregiverInMailchimpJob < ActiveJob::Base
  queue_as :default

  def perform(caregiver)
    begin
      gibbon_client = Gibbon::API.new('750dd46c8ae03cd0573b843d12eb06fc-us7')
      gibbon_client.lists.update_member(
        id: '8bc143f9c0',
        email: { email: caregiver.email },
        merge_vars: {
          FNAME: caregiver.first_name,
          LNAME: caregiver.last_name,
          BDAY: caregiver.date_of_birth ? caregiver.date_of_birth.strftime('%m/%d') : nil,
          ZIP: caregiver.zipcode,
          PHONE: caregiver.phone
        },
        double_optin: false
      )
    rescue Gibbon::MailChimpError => e
      gibbon_client = Gibbon::API.new('750dd46c8ae03cd0573b843d12eb06fc-us7')
      gibbon_client.lists.subscribe(
        id: '8bc143f9c0',
        email: { email: caregiver.email },
        merge_vars: {
          FNAME: caregiver.first_name,
          LNAME: caregiver.last_name,
          BDAY: caregiver.date_of_birth ? caregiver.date_of_birth.strftime('%m/%d') : nil,
          ZIP: caregiver.zipcode,
          PHONE: caregiver.phone
        },
        double_optin: false
      )
    end
  end
end
