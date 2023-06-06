class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  before_action :authenticate_employee!, :set_current_employee

  

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :role) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def set_current_employee
    Current.employee = current_employee
  end

 
end
