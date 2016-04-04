# == Schema Information
#
# Table name: avatars
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  format     :string(255)
#  size       :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Avatar < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :filename, :format, :size

  LARGE = { :width => 172, :height => 172, :crop => :fill, :gravity => :face }
  MEDIUM = { :width => 66, :height => 75, :crop => :fill, :gravity => :face }
  THUMB = { :width => 26, :height => 30, :crop => :fill, :gravity => :face }

  BASE_URL = "//res.cloudinary.com/carespotter/image/upload"
  DEFAULT_AVATAR_URL = "#{BASE_URL}/c_fit,h_172,w_172/default-avatar.gif"

  def is_real?
    true
  end

  def url type=:large
  	case type
  	when :large
  		"#{BASE_URL}/c_fill,g_face,h_172,w_172/#{filename}.#{format}"
  	when :medium
  		"#{BASE_URL}/c_fill,g_face,h_75,w_66/#{filename}.#{format}"
  	when :thumb
  		"#{BASE_URL}/c_fill,g_face,h_30,w_26/#{filename}.#{format}"
  	end
  end

  def self.upload(file, user)
  	create!(filename: "v#{file['version']}/#{file['public_id']}", format: file["format"], size: file["bytes"], user_id: user.id)
  end

  class AvatarNullObject
    def is_real?
        false
    end

  	def url type=:large
  		Avatar::DEFAULT_AVATAR_URL
  	end
  end

  private

  def self.to_cloundinary(file, user)
  	Cloudinary::Uploader.upload(file,
  		eager: [ LARGE, MEDIUM, THUMB ],
  		public_id: "#{user.first_name.downcase}-#{user.avatars.count}",
  		folder: "#{Rails.env.downcase}/#{user.class.name.pluralize.downcase}/#{user.id}")
  end
end
