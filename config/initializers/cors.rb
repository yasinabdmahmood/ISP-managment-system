Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
        expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Add any additional cookies you want to share here
    end
  end