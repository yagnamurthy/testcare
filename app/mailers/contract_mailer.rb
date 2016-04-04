class ContractMailer < ActionMailer::Base
  default from: "team@carespotter.com"

  def send_new_jobs_in_your_area caregiver, contract
  	@caregiver = caregiver
  	@contract = contract

    # attachments['welcome_packet.pdf'] = File.read('/Users/kyleszives/Documents/carespotter/invocies/oct20-26-szives.pdf')

  	mail to: @caregiver.email, subject: "CareSpotter: There is a new job posting in your area!"
  end

  def send_new_job
    mail to: 'darren@carespotter.com', subject: 'New job / Updated Job that hasnt been approved', body: ''
  end
end
