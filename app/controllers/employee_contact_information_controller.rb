class EmployeeContactInformationController < ApplicationController
  def new
    @new_employee_contact_information = EmployeeContactInformation.new
  end

  def create
    @new_employee_contact_information = EmployeeContactInformation.new(employee_contact_information_params)
    if @new_employee_contact_information.save
      redirect_to root_path
    else
      redirect_to new_employee_contact_information_path
    end
  end

  private

  def employee_contact_information_params
    params.require(:new_employee_contact_information).permit(:contact_info, :employee_id)
  end
end
