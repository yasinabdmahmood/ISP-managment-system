if Rails.env.production?
  Rails.application.config.session_store :cookie_store, 
    key: '_isp_managment_system_session', 
    domain: 'isp-system-react.onrender.com',
    path: '/',
    same_site: :none,
    secure: :true
else
  Rails.application.config.session_store :cookie_store, 
    key: '_isp_managment_system_session'
end
