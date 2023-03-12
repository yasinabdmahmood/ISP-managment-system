class EmployeeController < ApplicationController
  def index
    @employees = Employee.all.includes(:employee_contact_information)
    render json: @employees, include: { employee_contact_information: { only: [:contact_info] } }
  end
end
