Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://isp-react.netlify.app', 'https://642201687183b1000808f0d5--isp-react.netlify.app'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
        expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Add any additional cookies you want to share here
    end
  end