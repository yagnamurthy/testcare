# require 'twilio-ruby'

# # put your own credentials here
# account_sid = 'ACd0cc2ae7038fd66598328903c85adcee'
# auth_token = '67fc88de85e286634388ffe891f94532'

# # set up a client to talk to the Twilio REST API
# TWILIO_CLIENT = Twilio::REST::Client.new account_sid, auth_token

# SMSEasy::Client.configure(YAML.load("#{Rails.root}/config/sms.yml"))

SMSEasy::Client.config['from_address'] = "darren@carespotter.com"