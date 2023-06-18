class MyBackgroundJob < ApplicationJob
  queue_as :default

  def perform
    contact_information = EmployeeContactInformation.new(contact_info: '07501111111', employee_id: 1);
    contact_information.save
  end
end
