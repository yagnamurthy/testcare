# == Schema Information
#
# Table name: cover_letters
#
#  id           :integer          not null, primary key
#  caregiver_id :integer
#  body         :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CoverLetter < ActiveRecord::Base
  belongs_to :caregiver, :class_name => :user

end
