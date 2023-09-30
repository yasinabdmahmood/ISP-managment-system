desc "gen_daily_report"
require 'date'
task test3: :environment do

    specific_date = Date.parse("2023-09-02")

    # Query records created on the specific date
    records_on_specific_date = PaymentRecord.where(created_at: specific_date.beginning_of_day..specific_date.end_of_day)
    sum = 0
    records_on_specific_date.each do |payment|
        sum+= payment.amount
        p "#{payment.created_at.strftime('%Y/%-m/%-d')} ===> #{payment.amount}"
    end
    p records_on_specific_date.count
    p sum


end