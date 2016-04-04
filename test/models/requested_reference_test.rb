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

require 'test_helper'

class RequestedReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
