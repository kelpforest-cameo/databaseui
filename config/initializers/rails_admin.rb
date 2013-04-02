RailsAdmin.config do |config|
  config.authorize_with :cancan
  config.excluded_models = ["Role"]
end
