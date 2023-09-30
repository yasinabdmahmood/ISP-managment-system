desc "test4"
require 'date'
task test4: :environment do

    specific_date = Date.parse("2023-09-1")

    # Query records created on the specific date
    daily_reports = DailyReport.all
    monthly_reports = MonthlyReport.all
    daily_reports.each do |daily_report|
        payment = daily_report.data['report']['payment_statistics']['sum_of_total_payment']
        p "#{daily_report.created_at.strftime('%Y/%-m/%-d')} ===> #{payment}"
    end
    monthly_reports.each do |monthly_report|
       p monthly_report
    end


end