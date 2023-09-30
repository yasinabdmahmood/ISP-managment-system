desc "gen_daily_report"
require 'date'
task test2: :environment do
    profit = 0
    payment = 0
    daily_reports = DailyReport.where('extract(month from created_at) = ?', 9).order(created_at: :asc)
    monthly_report = MonthlyReport.where('extract(month from created_at) = ?', 9).first
    daily_reports.each do |daily_report|
        daily_report_payment = daily_report['data']['report']['payment_statistics']['sum_of_total_payment']
        daily_report_date = daily_report.created_at.strftime('%Y/%-m/%-d')
        p "#{daily_report_date} ====>  #{daily_report_payment}"
        payment += daily_report_payment 
    end
    p '+++++++++++++++++++++++++++++++++++++'
    p "monthly report payment ===> #{monthly_report['data']['report']['payment_statistics']['sum_of_total_payment']}"
    p '+++++++++++++++++++++++++++++++++++++'
    p "sum of daily reports payment ===> #{payment}"
    p '+++++++++++++++++++++++++++++++++++++'
    p "munber of daily reports  ===> #{daily_reports.count}"
end