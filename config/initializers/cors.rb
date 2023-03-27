Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://6420f754960c8a37a162551d--aesthetic-centaur-fad1cd.netlify.app'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Add any additional headers you want to expose here
  end
end