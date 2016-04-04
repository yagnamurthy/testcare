if Rails.env.production?
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = "use_your_merchant_id"
  Braintree::Configuration.public_key = "use_your_public_key"
  Braintree::Configuration.private_key = "use_your_private_key"
else
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = "hg9zr35vs25nzx9k"
  Braintree::Configuration.public_key = "93qbx84vyg5hk6m7"
  Braintree::Configuration.private_key = "dcf4a7fd24b369d3c77e06086fefc13f"
end
