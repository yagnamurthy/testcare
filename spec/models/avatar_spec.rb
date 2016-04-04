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

require 'spec_helper'

describe Avatar do
  
  it { should belong_to :user }
  it { should validate_presence_of(:filename) }
  it { should validate_presence_of(:format) }
  it { should validate_presence_of(:size) }

  context '#upload' do 
  	it 'uploads image to cloundinary' do 
  		user = build(:user)
  		file = File.expand_path('app/assets/images/default-avatar.gif')

  		avatar = Avatar.upload(file, user)
  		avatar.filename.should eq("test/users/10000/john-0")
  	end
  end

  context '#url' do 
  	it 'returns valid url' do 
  		user = create(:user)
  		file = File.expand_path('app/assets/images/default-avatar.gif')  
  		avatar = Avatar.upload(file, user)

  		RestClient.get(avatar.url){|response, request, result| response }.code.should eq(200)	
  	end
  end

end
