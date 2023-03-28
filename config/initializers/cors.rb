Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://isp-react.netlify.app', 'https://642201687183b1000808f0d5--isp-react.netlify.app', 'https://isp-system-react.onrender.com'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true,
        expose: ['access-token', 'expiry', 'token-type', 'uid', 'client', '_isp_managment_system_session', 'Set-Cookie'],
        :credentials => true, 
        :same_site => :none,
        :secure => true
    end
end