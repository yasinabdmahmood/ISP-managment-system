require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ISPManagmentSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.time_zone = 'Baghdad'
    config.active_record.default_timezone = :local
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://6420f754960c8a37a162551d--aesthetic-centaur-fad1cd.netlify.app'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Add any additional headers you want to expose here
      end
    end
    

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
