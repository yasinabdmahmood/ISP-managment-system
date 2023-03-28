# config/application.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', 
      headers: :any, 
      methods: [:get, :post, :put, :delete],
      credentials: true,
      expose: ['Set-Cookie'],
      max_age: 600,
      same_site: 'none',
      secure: true
  end
end
