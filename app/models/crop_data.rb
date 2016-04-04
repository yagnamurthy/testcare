# == Schema Information
#
# Table name: crop_data
#
#  id      :integer          not null, primary key
#  crop_x  :integer
#  crop_y  :integer
#  crop_w  :integer
#  crop_h  :integer
#  user_id :integer
#

class CropData < ActiveRecord::Base
	belongs_to :user

	validates :user, presence: true
	validates :crop_x, presence: true
	validates :crop_y, presence: true
	validates :crop_h, presence: true
	validates :crop_w, presence: true

	def self.create_or_update(user_id, attributes)
    	crop_data=where(user_id: user_id).first

    	if crop_data
    		crop_data.update(attributes)
    	else 
    		create!(attributes)
    	end
  	end

  	def cropping?
  		!self.crop_x.zero? || !self.crop_y.zero? || !self.crop_h.zero? || !self.crop_w.zero?
  	end
end
