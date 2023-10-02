desc "test4"
require 'date'
task test4: :environment do

    start_date = Date.parse("2023-09-1")

    end_date = Date.parse("2023-09-30")

    sum_of_payment = 0
    sum_of_profit = 0

    # Query records created on the specific date
    daily_reports = DailyReport.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    monthly_report = MonthlyReport.where(created_at: start_date.beginning_of_day..end_date.end_of_day).first
    daily_reports.each do |daily_report|
        payment = daily_report.data['report']['payment_statistics']['sum_of_total_payment']
        profit = daily_report.data['report']['profit_statistics']['sum_of_total_profit']
        sum_of_payment+=payment
        sum_of_profit +=profit
        p "#{daily_report.created_at.strftime('%Y/%-m/%-d')} ===> #{payment} ===> #{profit}"
    end
    monthly_report_payment = 
    p '==============================='
    p "Tested Sum of total payment = #{sum_of_payment}"
    p "Actual Sum of total payment = #{monthly_report.data['report']['payment_statistics']['sum_of_total_payment']}"
    p "Tested Sum of total profit = #{sum_of_profit}"
    p "Actual Sum of total profit = #{monthly_report.data['report']['profit_statistics']['sum_of_total_profit']}"

    if sum_of_payment == 

end