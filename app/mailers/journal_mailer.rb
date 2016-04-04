class JournalMailer < ActionMailer::Base
  default from: "team@carespotter.com"

  def send_notification user, participants, journal
  	@user = user 
  	@journal = journal
  	@contract = @journal.contract

  	mail :to => participants.map { |u| u.email }, :subject => "#{user.first_name} has made a new journal entry - #{journal.created_at.strftime("%b. %d %Y")}"
  end

end
