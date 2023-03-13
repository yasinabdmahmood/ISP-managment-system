# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :verify_authenticity_token
  # before_action :require_admin, only: [:create]

  

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    new_employee = Employee.new(new_employee_params)
    if new_employee.save
      render json: new_employee
    else
      render status: :unprocessable_entity, json: { error: "Unable to save new employee", messages: new_employee.errors.full_messages }
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private

  def new_employee_params
    params.require(:new_employee).permit(:name, :email, :password)
  end

  def require_admin
    unless current_employee && current_employee.admin == 'admin'
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
