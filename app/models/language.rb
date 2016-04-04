# == Schema Information
#
# Table name: languages
#
#  name :string(255)
#  code :string(2)        not null, primary key
#

class Language < ActiveRecord::Base
  has_and_belongs_to_many :users

  self.primary_key = "code"
  
end
