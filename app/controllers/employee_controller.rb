class EmployeeController < ApplicationController
  def index
    @employees = Employee.all.includes(:employee_contact_information)
  end
end
