# == Schema Information
#
# Table name: care_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CareType < ActiveRecord::Base
    has_and_belongs_to_many :contracts
end
