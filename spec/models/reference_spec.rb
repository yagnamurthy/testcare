# == Schema Information
#
# Table name: references
#
#  id                   :integer          not null, primary key
#  body                 :text(65535)
#  user_id              :integer
#  created_at           :datetime
#  updated_at           :datetime
#  caregiver_id         :integer
#  relationship         :integer
#  name                 :string(255)
#  dependability        :integer
#  technical_ability    :integer
#  communication_skills :integer
#  compassion           :integer
#

require 'spec_helper'

describe Reference do
  
	context '#send_to_emails' do
		let(:caregiver) { mock_model("Caregiver", md5hash: "1kj32l4kj1l23k4j", first_name: 'Kyle', last_name: 'Szives') }
    	let(:email) { 'kjszives@gmail.com' }
    	let(:invalid_email) { 'aklsjdf' }

		it 'returns true when given valid emails' do
			Reference.send_by_emails(email, caregiver).should eq(true)
		end

		it 'returns an array of errors when given invalid emails' do
			Reference.send_by_emails(invalid_email, caregiver).should eq(["aklsjdf is not valid"])
		end
	end




  # def user_avatar
  #   user.avatar.url(:medium)
  # end

  # def user_name
  #   user.first_name
  # end

  # def caregiver_name
  #   caregiver.first_name
  # end

  # def self.relationship_options
  #   ['first relationship', 'second_relationship']
  # end

  # def self.send_to_emails emails, caregiver
  #   errors = []

  #   emails.split(',').each do |email|
  #     if email.match(/@/)
  #       send_mail email, caregiver
  #     else
  #       errors << "#{email} is not valid"
  #     end
  #   end
  #   return errors.length ? errors : true
  # end

  # def self.send_mail email, caregiver
  #   Delayed::Job.enqueue TestimonialMailer.send_testimonial_request_mail(email, caregiver).deliver
  # end


end
