desc "test_report"
require 'date'
task test_report: :environment do
    today = DateTime.now

    # Query the "payment_records" table for records created in the last 24 hours
    records_created_last_24_hours = PaymentRecord
        .joins(:subscription_record)
        .where("payment_records.created_at >= ?", 24.hours.ago)

    subscription_types = SubscriptionType.all
    # Initialize an empty hash
    category_profit_hash = {}
    # Iterate through the SubscriptionTypes
    subscription_types.each do |subscription_type|
    # Use the category as the key and profit as the value and store it in the hash table
    category_profit_hash[subscription_type.category] = subscription_type.profit
    end

    # Initialize the variables to store the daily report
    sum_of_total_payment = 0
    sum_of_category_payment = {}
    sum_of_total_profit = 0
    sum_of_category_profit = {}

    # Iterate through all the payment records created in the last 24 hours
    # and calculate the daily report accordingly 
    records_created_last_24_hours.each do |payment_record|

        # Get the category to which the current payment record belongs 
        category = payment_record.subscription_record.category

        # Add payment_record.amount to the sum_of_total_payment
        sum_of_total_payment += payment_record.amount.to_i


        #calculate the profit for the current payment_record
        profit_from_current_payment = (category_profit_hash[category]*(payment_record.amount / payment_record.subscription_record.cost)).to_i

        # Add the calculated profit to the sum_of_total_profit
        sum_of_total_profit += profit_from_current_payment
   
        # Add the payment record amount to the corresponding category in the sum_of_category_payment hash
        if sum_of_category_payment.key?(category)
            sum_of_category_payment[category] += payment_record.amount.to_i
        else
            sum_of_category_payment[category] = payment_record.amount.to_i
        end

        # Add the profit for the current payment record to the corresponding category in the sum_of_category_profit hash
        if sum_of_category_profit.key?(category)
            sum_of_category_profit[category] += profit_from_current_payment.to_i
        else
            sum_of_category_profit[category] = profit_from_current_payment.to_i
        end
    end
    
    # the follwing commented code are for the testing purpose
    # p "sum_of_total_payment => #{sum_of_total_payment}"
    # p "sum_of_category_payment => #{sum_of_category_payment}"
    # p "sum of profit => #{sum_of_total_profit}"
    # p "profit pi chart => #{sum_of_category_profit}"


    # Create the daily report
    todays_report = DailyReport.create(
        data: {
            date: today,
            report: {
                payment_statistics: {
                    sum_of_total_payment: sum_of_total_payment,
                    sum_of_category_payment: sum_of_category_payment
                },
                profit_statistics: {
                    sum_of_total_profit: sum_of_total_profit,
                    sum_of_category_profit: sum_of_category_profit
                }
            },
            report_type: 'Daily'
        }
    )

    # monthly report
    # current_month = Date.today.month
    # last_record = DailyReport.last

    # if !last_record || last_record.created_at.month != current_month
    #     todays_report = DailyReport.create(
    #     data: {
    #         date: today,
    #         some_dummy_data: ['alex','sam','john'],
    #         report_type: 'Monthly'
    #     }
    # )
    # end
end