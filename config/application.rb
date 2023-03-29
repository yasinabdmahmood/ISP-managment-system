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
    if ENV['RAILS_ENV'] == 'production' || ENV['RAILS_ENVIRONMENT'] == 'production'
      config.middleware.use ActionDispatch::Session::CookieStore,
      key: '_isp_managment_system_session', path: '/', same_site: :None, secure: true 
    end
    
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins 'https://isp-react.netlify.app', 'https://642201687183b1000808f0d5--isp-react.netlify.app', 'https://isp-system-react.onrender.com'
    #     resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
    #       expose: ['access-token', 'expiry', 'token-type', 'uid', 'client', '_isp_managment_system_session'] # Add any additional headers you want to expose here
    #   end
    # end
    

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
