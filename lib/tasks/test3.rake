desc "gen_daily_report"
require 'date'
task test3: :environment do

    specific_date = Date.parse("2023-09-01")

    # Query records created on the specific date
    records_on_specific_date = PaymentRecord.where(created_at: specific_date.beginning_of_day..specific_date.end_of_day)
    daily_report = DailyReport.where(created_at: specific_date.beginning_of_day..specific_date.end_of_day).first
    sum = 0
    records_on_specific_date.each do |payment|
        sum+= payment.amount
        p "#{payment.created_at.strftime('%Y/%-m/%-d')} ===> #{payment.amount}"
    end
    p "Number of payment records ==> #{records_on_specific_date.count}"
    p "Sum of payment records ===> #{sum}"
    p "Sum of pay  records accouding to daily report ===> #{daily_report.data['report']['payment_statistics']['sum_of_total_payment']}"
    p "daily report date ===> #{daily_report.created_at}"


end