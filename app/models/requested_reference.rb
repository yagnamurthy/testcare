# == Schema Information
#
# Table name: requested_references
#
#  id           :integer          not null, primary key
#  name         :text(65535)
#  phone        :text(65535)
#  email        :text(65535)
#  caregiver_id :integer
#

class RequestedReference < ActiveRecord::Base
  belongs_to :caregiver

  after_save :send_mail

  private

  def send_mail
    TestimonialMailer.send_testimonial_request_mail(self, self.caregiver).deliver_later
  end

end
