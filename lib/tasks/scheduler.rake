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

    subscription_types = SubscriptionType.all; 
    
    # Initialize an empty hash
    category_profit_hash = {}

    # Iterate through the SubscriptionType records
    subscription_types.each do |subscription_type|
    # Use the category as the key and profit as the value in the hash
    category_profit_hash[subscription_type.category] = subscription_type.profit.to_i
    end
    p category_profit_hash

    # Initialize the variables
    sum_of_paied_money = 0
    pi_chart_for_paied_money = {}
    sum_of_profit = 0
    pi_chart_of_profit = {}

    # Assuming records_created_last_24_hours is an array of PaymentRecord objects
    records_created_last_24_hours.each do |item|
        category = item.subscription_record.category
        # 1. Add item.amount to the sum
        sum_of_paied_money += item.amount.to_i
        profit_from_current_payment = (category_profit_hash[category]*(item.amount / item.subscription_record.cost)).to_i
        sum_of_profit += profit_from_current_payment
        p "category => #{category}"
        p "total profit for this category => #{category_profit_hash[category]}"
        p "paid amount => #{item.amount.to_i}"
        p "total cost for this category => #{item.subscription_record.cost.to_i}"
        p "profit for the current pay => #{profit_from_current_payment}"
        p "---------------------------------------------------"
        

        
        
        # 2. Check item.subscription_record.category and update the pi_chart
        
        if pi_chart_for_paied_money.key?(category)
            pi_chart_for_paied_money[category] += item.amount.to_i
        else
            pi_chart_for_paied_money[category] = item.amount.to_i
        end

        if pi_chart_of_profit.key?(category)
            pi_chart_of_profit[category] += profit_from_current_payment.to_i
        else
            pi_chart_of_profit[category] = profit_from_current_payment.to_i
        end
    end

    p sum_of_paied_money
    p pi_chart_for_paied_money
    p "sum of profit => #{sum_of_profit}"
    p "profit pi chart => #{pi_chart_of_profit}"

    # Now, you have the sum of item.amount in the 'sum' variable
    # and the pi_chart hash with categories as keys and their sums as values




    
    todays_report = DailyReport.create(
        data: {
            date: today,
            some_dummy_data: {
                payment_statistics: {
                    sum_of_total_payment: sum_of_paied_money,
                    sum_of_category_payment: pi_chart_for_paied_money
                },
                profit_statistics: {
                    sum_of_total_profit: sum_of_profit,
                    sum_of_category_profit: pi_chart_of_profit
                }
            },
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