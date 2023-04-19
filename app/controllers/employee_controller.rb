class EmployeeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @employees = Employee.all.includes(:employee_contact_information)
    render json: @employees, include: { employee_contact_information: { only: [:id, :contact_info] } }
  end
  # employee/update
  def update
    @employee = Employee.find(params[:id])

    # if the current user is not admin then they can not elevate an employee to become admin
    if current_employee.role != 'admin'
      render json: {message: 'You are not authorized to perform this action'}, status: 401
      return
    end

    if @employee.update(employee_params)
      render json: { message: 'Success' }, status: 200
    else
      render json: {message: 'error'}, status: 400
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation, :role)
  end

end
