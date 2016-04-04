class TextMessageJob < ActiveJob::Base
  queue_as :default

  def perform(caregiver)
    easy = SMSEasy::Client.new
    easy.deliver(caregiver.phone, caregiver.carrier, 'HI! A new care job has been posted on CareSpotter in your area. Go to www.carespotter.com and login to apply. Good luck!')
  end
end
