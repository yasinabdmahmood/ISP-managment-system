desc "test_report"
task test_report: :environment do
    contact_information = EmployeeContactInformation.new(contact_info: '07501111111', employee_id: 1);
    contact_information.save
    p '0000000000000000000000000000'
    p Employee.first
    p '0000000000000000000000000000'
end