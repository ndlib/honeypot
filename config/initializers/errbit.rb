Airbrake.configure do |config|
  config.api_key = '4426df076a6b5b08e1a91378a0e26596'
  config.host    = 'errbit.library.nd.edu'
  config.port    = 443
  config.secure  = config.port == 443
  config.user_attributes = [:id, :username, :name]
end
