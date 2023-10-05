desc "test5"
require 'date'
task test5: :environment do
    # Extract year and month from params
    year = 2023
    month = 9
    
  
    # Create a Date object for the first day of the specified month and year
    start_date = Date.parse("#{year}-#{month}-1")
    end_date = Date.parse("#{year}-#{month}-1")
  
    # Find the monthly report created in the specified month and year
    monthly_report = MonthlyReport.find_by(created_at: start_date.beginning_of_day..end_date.end_of_day)
  
    if monthly_report
      p monthly_report
    else
      p "No monthly report found for the specified year and month" 
    end

end