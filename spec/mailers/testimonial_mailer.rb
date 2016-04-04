require 'spec_helper'
 
describe TestimonialMailer do
  describe '#ask_for_reference' do
    let(:caregiver) { mock_model("Caregiver", md5hash: "1kj32l4kj1l23k4j", first_name: 'Kyle', last_name: 'Szives') }
    let(:emails) { ['kjszives@gmail.com', 'kyle.szives@gmail.com'] }
    let(:mail) { TestimonialMailer.send_testimonial_request_mail(emails[0], caregiver) }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "#{caregiver.first_and_last_initial} is asking for a reference!"
    end

    it 'renders the reciever email' do
      mail.to.should eq([emails[0]])
    end

    it 'renders the sender email' do
      mail.from.should eq(["darren@carespotter.com"])
    end

    it 'assigns @testimonial_url' do
      mail.body.encoded.should match(caregiver.md5hash)
    end

    # it 'assigns @user' do
    #   mail.body.encoded.should match()
    # end


 
    # #ensure that the receiver is correct
    # it 'renders the receiver email' do
    #   mail.to.should == [user.email]
    # end
 
    # #ensure that the sender is correct
    # it 'renders the sender email' do
    #   mail.from.should == ['noreply@empresa.com']
    # end
 
    # #ensure that the @name variable appears in the email body
    # it 'assigns @name' do
    #   mail.body.encoded.should match(user.name)
    # end
 
    # #ensure that the @confirmation_url variable appears in the email body
    # it 'assigns @confirmation_url' do
    #   mail.body.encoded.should match("http://aplication_url/#{user.id}/confirmation")
    # end
  end
end