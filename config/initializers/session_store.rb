Rails.application.config.session_store :cookie_store, :key => '_isp_managment_system_session',
  :domain => :all,
  :same_site => :none,
  :secure => :true,
  :tld_length => 3