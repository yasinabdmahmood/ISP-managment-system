# frozen_string_literal: true

class Employees::SessionsController < Devise::SessionsController

  skip_before_action :verify_authenticity_token

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    
    render json: resource.as_json(only: [:id, :name, :email, :role])
  end
  

  # def create
  #   super do |employee|
  #     if employee.role == 'admin'
  #       cookies[:role] = "admin"
  #     else
  #       cookies[:role] = "employee"
  #     end
  #     render json: employee, status: :created
  #   end
  # end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
