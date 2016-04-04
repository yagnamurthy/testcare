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

class Reference < ActiveRecord::Base

  belongs_to :caregiver, :counter_cache => true
  belongs_to :user

  default_scope -> { order('created_at ASC') }

  validates :body, presence: true
  validates :dependability, :numericality => { :less_than_or_equal_to => 5 }
  validates :communication_skills, :numericality => { :less_than_or_equal_to => 5 }
  validates :compassion, :numericality => { :less_than_or_equal_to => 5 }
  validates :technical_ability, :numericality => { :less_than_or_equal_to => 5 }


  def user_name
    user ? user.first_name :
      name ? name : 'Unknown'
  end

  def author
    user ? user :
      User::UserNullObject.new
  end

  def caregiver_name
    caregiver.first_name
  end

  def self.relationship_options
    [
      [ 'coworker', 1 ],
      [ 'friend', 2 ],
      [ 'former employer', 3 ],
      [ 'former client/patient', 4 ]
    ]
  end

end
