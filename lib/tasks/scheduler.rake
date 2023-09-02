desc "test_report"
require 'date'
task test_report: :environment do
    today = DateTime.now

    # Calculate the timestamp for 24 hours ago
    twenty_four_hours_ago = 24.hours.ago

    # Query the "daily_reports" table for records created in the last 24 hours
    records_created_last_24_hours = PaymentRecord
        .joins(:subscription_record)
        .where("payment_records.created_at >= ?", 24.hours.ago)

    # Initialize the variables
    sum_of_paied_money = 0
    pi_chart_for_paied_money = {}

    # Assuming records_created_last_24_hours is an array of PaymentRecord objects
    records_created_last_24_hours.each do |item|
    # 1. Add item.amount to the sum
    sum_of_paied_money += item.amount
    
    # 2. Check item.subscription_record.category and update the pi_chart
    category = item.subscription_record.category
    if pi_chart_for_paied_money.key?(category)
        pi_chart_for_paied_money[category] += item.amount
    else
        pi_chart_for_paied_money[category] = item.amount
    end
    end

    p sum_of_paied_money
    p pi_chart_for_paied_money

    # Now, you have the sum of item.amount in the 'sum' variable
    # and the pi_chart hash with categories as keys and their sums as values




    
    todays_report = DailyReport.create(
        data: {
            date: today,
            some_dummy_data: ['alex','sam','john'],
            report_type: 'Daily'
        }
    )

    # monthly report
    current_month = Date.today.month
    last_record = DailyReport.last

    if !last_record || last_record.created_at.month != current_month
        todays_report = DailyReport.create(
        data: {
            date: today,
            some_dummy_data: ['alex','sam','john'],
            report_type: 'Monthly'
        }
    )
    end
end