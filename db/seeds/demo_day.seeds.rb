@caregivers = Caregiver.all

@caregiver.each_with_index do |caregiver, index|
	caregiver.avatar = URI.parse("http://api.randomuser.me/0.2/portraits/women/{show + 1}.jpg")
	caregiver.hours = 0
	caregiver.save!
end
