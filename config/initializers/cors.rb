Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://isp-react.netlify.app', 'http://localhost:3001', 'https://isp-system-react.onrender.com'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
        expose: ['access-token', 'expiry', 'token-type', 'uid', 'client', '_isp_managment_system_session', 'Set-Cookie'],
        :same_site => :none,
        :secure => true
    end
end