class UserMailer < ActionMailer::Base
  default from: "darren@carespotter.com"

  def send_greeting_email user 
    @user = user 
    # attachments['welcome_packet.pdf'] = File.read('/Users/kyleszives/Documents/carespotter/invocies/oct20-26-szives.pdf')
    mail to: user.email, subject: "Welcome to CareSpotter #{@user.first_name}"
  end

  def send_interview_guide_email user 
    @user = user 
    attachments['carespotter-family-interview-questions.pdf'] = File.read(Carespotter::Application.assets.find_asset('carespotter-family-interview-questions.pdf').pathname.to_s)
    attachments['carespotter-care-plan.docx'] = File.read(Carespotter::Application.assets.find_asset('carespotter-care-plan.docx').pathname.to_s)
    attachments['carespotter-onboarding-caregiver.pdf'] = File.read(Carespotter::Application.assets.find_asset('carespotter-onboarding-caregiver.pdf').pathname.to_s)

    mail to: user.email, subject: "CareSpotter Interview and Hiring Toolkit"
  end
end
