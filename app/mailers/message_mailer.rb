class MessageMailer < ActionMailer::Base
  default from: "team@carespotter.com"

  def send_message participant, from, message
  	@participant = participant
  	@from = from
  	@message = message

  	mail to: @participant.email, subject: "You have a new message on CareSpotter!"
  end

end
