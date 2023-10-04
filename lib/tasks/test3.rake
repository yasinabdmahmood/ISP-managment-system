desc "gen_daily_report"
require 'date'
task test3: :environment do

    specific_date = Date.parse("2023-09-21")

    # Query records created on the specific date
    records_on_specific_date = PaymentRecord.where(created_at: specific_date.beginning_of_day..specific_date.end_of_day)
    daily_report = DailyReport.find_by(created_at: specific_date.beginning_of_day..specific_date.end_of_day)
    sum_of_payment = 0
    sum_of_profit = 0
    records_on_specific_date.each do |payment|
        sum_of_payment+= payment.amount
        profit = payment.subscription_record.subscription_type.profit
        cost = payment.subscription_record.subscription_type.cost
        payed_amount = payment.amount
        sum_of_profit+= payed_amount*profit/cost
        sum_of_payment += payed_amount
        p "#{payment.created_at.strftime('%Y/%-m/%-d')} ===> #{payment.amount}"
    end
    report_sum_of_payment = daily_report.data['report']['payment_statistics']['sum_of_total_payment']
    report_sum_of_profit = daily_report.data['report']['profit_statistics']['sum_of_total_profit']
    p "Calculated sum of payment from test ==> #{sum_of_payment}"
    p "Calculated sum of payment from report ===> #{report_sum_of_payment}"
    p "Calculated sum of profit from test ==> #{sum_of_profit}"
    p "Calculated sum of profit from report ===> #{report_sum_of_profit}"

    if sum_of_payment == report_sum_of_payment
        p "The test for payment report was passed"
    end

    if sum_of_profit == report_sum_of_profit
        p "The test for profit report was passed"
    end


end