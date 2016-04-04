Airbrake.configure do |config|
  config.api_key = '291df893af5bf6aafb0a09a71a08ca84'
  config.host    = 'carespotter-breaks.herokuapp.com'
  config.port    = 443
  config.secure  = config.port == 443
end