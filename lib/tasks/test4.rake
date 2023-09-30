desc "test4"
require 'date'
task test4: :environment do

    specific_date = Date.parse("2023-09-1")

    # Query records created on the specific date
    daily_reports = DailyReport.where(created_at: specific_date.beginning_of_day..specific_date.end_of_day)
    monthly_report = daily_report.monthly_report.first
    sum = 0
    daily_reports.each do |daily_report|
        payment = daily_report.data['report']['payment_statistics']['sum_of_total_payment']
        sum+= payment
        p "#{daily_report.created_at.strftime('%Y/%-m/%-d')} ===> #{payment}"
    end
    p "Number of daily records ==> #{daily_reports.count}"
    p "Sum of daily records ===> #{sum}"
    p "Sum of daily  records accouding to monthly report ===> #{monthly_report.data['report']['payment_statistics']['sum_of_total_payment']}"
    p "monthly report date ===> #{monthly_report.created_at}"


end