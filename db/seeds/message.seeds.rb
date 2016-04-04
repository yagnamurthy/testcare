require "rubygems"

(1..15).each do 
	@message = Message.create({
		body: Faker::Lorem.paragraphs(3).join(","),
		subject: Faker::Lorem.sentences(1).join(",")
	})

	(1..25).each do 
		MailReceipt.create({
			user_id: User.all.sample.id,
			recipient_id: User.all.sample.id,
			message_id: @message.id,
			read: 0
		})
	end
end
