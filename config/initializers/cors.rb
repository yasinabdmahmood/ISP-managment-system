Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Add any additional cookies you want to share here
  end

  allow do
    origins 'https://6420f754960c8a37a162551d--aesthetic-centaur-fad1cd.netlify.app/'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Add any additional cookies you want to share here
  end

  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: false
  end

end