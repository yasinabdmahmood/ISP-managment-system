class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  before_action :authenticate_employee!

  before_action :set_cors_headers

  private

  def set_cors_headers
    response.set_header "Access-Control-Allow-Origin", origin
  end

  def origin
    request.headers["Origin"] || "*"
  end


  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :role) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

 
end
