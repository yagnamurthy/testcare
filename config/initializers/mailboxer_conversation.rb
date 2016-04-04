Mailboxer::Conversation.class_eval do

  scope :not_trash, lambda {|participant|
    participant(participant).merge(Mailboxer::Receipt.not_trash)
  }

end
