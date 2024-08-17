require 'set'
module Report
    extend ActiveSupport::Concern

    # data: {
    #     date: payment_date,
    #     report: {
    #         payment_statistics: {
    #             sum_of_total_payment: 0,
    #             some_of_expenses: 0,
    #             trial_balance: 0,
    #             sum_of_category_payment: {}
    #         },
    #         profit_statistics: {
    #             sum_of_total_profit: 0,
    #             sum_of_category_profit: {}
    #         }
    #     },
    #     report_type: 'Daily'
    # }

  
    def add_current_expense_to_belonged_daily_report(expense,daily_report)
        # extract the data field from the given daily report object 
        data = daily_report.data
        
        # Extract the amount filed of the given expense record object
        amount = expense.amount

        # sum_of_total_payment = data['report']['payment_statistics']['sum_of_total_payment']
        # sum_of_category_payment = data['report']['payment_statistics']['sum_of_category_payment']
        # sum_of_expenses = data['report']['payment_statistics']['some_of_expenses']
        # trial_balance = data['report']['payment_statistics']['trial_balance']
        # sum_of_total_profit = data['report']['profit_statistics']['sum_of_total_profit']
        # sum_of_category_profit = data['report']['profit_statistics']['sum_of_category_profit']
        # date = data['date']

        trial_balance, sum_of_expenses = extract_daily_report_data(data,[:trial_balance, :sum_of_expenses]) 
        trial_balance -= amount
        sum_of_expenses = sum_of_expenses.to_i
        sum_of_expenses += amount

        data = updateDailyReportDataByKey(data, {:sum_of_expenses => sum_of_expenses.to_i, :trial_balance => trial_balance.to_i})
        
        # updated_data['report']['payment_statistics']['sum_of_expenses'] = sum_of_expenses.to_i
        # updated_data['report']['payment_statistics']['trial_balance'] = trial_balance.to_i
        

        daily_report.update(data: data)
        
    end



    def extract_daily_report_data(data,requested_fields)
        # this method takes the data field of daily report and 
        # returns the reqired fileds specified in the given array for example
        # x,y = extract_report_data(data,[:trial_balance, :sum_of_expenses]) 
        # x will take trial_balnce and y takes sum_of_expenses of daily report
        all_fields = {
            sum_of_total_payment: data['report']['payment_statistics']['sum_of_total_payment'],
            sum_of_category_payment: data['report']['payment_statistics']['sum_of_category_payment'],
            sum_of_expenses: data['report']['payment_statistics']['sum_of_expenses'],
            trial_balance: data['report']['payment_statistics']['trial_balance'],
            sum_of_total_profit: data['report']['profit_statistics']['sum_of_total_profit'],
            sum_of_category_profit: data['report']['profit_statistics']['sum_of_category_profit'],
            date: data['date']
        }
        result = [];
        requested_fields.each do |element|
        result << all_fields[element]
        end
        result
    end

    def updateDailyReportDataByKey(data, keys)
        # this method takes the data field of the daily report which is 
        # a hash table and another hash table that has the keys that exist insied the data hash then
        # modifies the specified keys and finally returns the modified hash
        # for example 
        # data = updateDailyReportByKey(DailyReport.find(23),{:sum_of_total_payment => 25, :sum_of_expenses => 25000})
        # the above line of code modifies the sum_of_total_payment and sum_of_expenses of the given daily report
        # note that it does not cause the daily report upddate , it only returns new hash table
        # that represents the modified version of the data field of specific daily report 
        
        data['report']['payment_statistics']['sum_of_total_payment'] = keys[:sum_of_total_payment].to_i if keys.key?(:sum_of_total_payment)
        data['report']['payment_statistics']['sum_of_category_payment'] = keys[:sum_of_category_payment] if keys.key?(:sum_of_category_payment)
        data['report']['payment_statistics']['sum_of_expenses'] = keys[:sum_of_expenses].to_i if keys.key?(:sum_of_expenses)
        data['report']['payment_statistics']['trial_balance'] = keys[:trial_balance].to_i if keys.key?(:trial_balance)
        data['report']['profit_statistics']['sum_of_total_profit'] = keys[:sum_of_total_profit].to_i if keys.key?(:sum_of_total_profit)     
        data['report']['profit_statistics']['sum_of_category_profit'] = keys[:sum_of_category_payment] if keys.key?(:sum_of_category_profit)        
        data['report']['sub_type_counter'] = keys[:sub_type_counter] if keys.key?(:sub_type_counter)
        data['date'] = keys[:sum_of_category_payment] if keys.key?(:date)
        data
    end

    def create_empty_daily_record_for_current_payment(payment_date)
        # this method creates a new daily report for the given payment date
        daily_report = DailyReport.create(
                data: {
                    date: payment_date,
                    sub_type_counter: {},
                    report: {
                        payment_statistics: {
                            sum_of_total_payment: 0,
                            sum_of_expenses: 0,
                            trial_balance: 0,
                            sum_of_category_payment: {}
                        },
                        profit_statistics: {
                            sum_of_total_profit: 0,
                            sum_of_category_profit: {}
                        }
                    },
                    report_type: 'Daily'
                }
        )
        daily_report
    end 

    def add_current_payment_to_belonged_daily_report(daily_report, payment_record)
        # this method takes the daily report and the payment record and
        # adds the payment record to the daily report and updates the daily report
        
        # extract the data field from the given daily report object
        data = daily_report.data
        
        # Extract the keys from the data field of the daily report
        # that needs to be updated
        sum_of_total_payment,
        sum_of_category_payment,
        trial_balance,
        sum_of_total_profit,
        sum_of_category_profit = extract_daily_report_data(data,[:sum_of_total_payment, :sum_of_category_payment, :trial_balance, :sum_of_total_profit, :sum_of_category_profit])

        # Get the category to which the current payment record belongs 
        category = payment_record.subscription_record.subscription_type.category

        # Add payment_record.amount to the sum_of_total_payment
        sum_of_total_payment += payment_record.amount.to_i

        # Get the profit for the category to which the current payment record belongs
        category_profit = payment_record.subscription_record.subscription_type.profit

        #calculate the profit for the current payment_record
        profit_from_current_payment = (category_profit*(payment_record.amount / payment_record.subscription_record.cost)).to_i
        
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

        # Add the payment record amount to the trial balance
        trial_balance = trial_balance.to_i
        trial_balance += payment_record.amount.to_i

        # update the data field of the daily report
        data = updateDailyReportDataByKey(data, {:sum_of_total_payment => sum_of_total_payment, :sum_of_category_payment => sum_of_category_payment, :trial_balance => trial_balance, :sum_of_total_profit => sum_of_total_profit, :sum_of_category_profit => sum_of_category_profit})
        daily_report.update(data: data)
    end

    def remove_current_payment_from_daily_report(payment_record)
        # this method takes the payment record that is going to be deleted
        # and removes it from the daily report

        payment_date = payment_record.created_at.to_date
  
        daily_report = DailyReport.find_by(created_at: payment_date.beginning_of_day..payment_date.end_of_day)


        data = daily_report.data

        sum_of_total_payment = data['report']['payment_statistics']['sum_of_total_payment']
        sum_of_category_payment = data['report']['payment_statistics']['sum_of_category_payment']
        sum_of_expenses = data['report']['payment_statistics']['sum_of_expenses']
        trial_balance = data['report']['payment_statistics']['trial_balance']
        sum_of_total_profit = data['report']['profit_statistics']['sum_of_total_profit']
        sum_of_category_profit = data['report']['profit_statistics']['sum_of_category_profit']
        date = data['date']

        # Get the category to which the current payment record belongs 
        category = payment_record.subscription_record.subscription_type.category

        # Add payment_record.amount to the sum_of_total_payment
        sum_of_total_payment -= payment_record.amount.to_i
        category_profit = payment_record.subscription_record.subscription_type.profit


        #calculate the profit for the current payment_record
        profit_from_current_payment = (category_profit*(payment_record.amount / payment_record.subscription_record.cost)).to_i

        # Add the calculated profit to the sum_of_total_profit
        sum_of_total_profit -= profit_from_current_payment
   
        # Add the payment record amount to the corresponding category in the sum_of_category_payment hash
        if sum_of_category_payment.key?(category)
            sum_of_category_payment[category] -= payment_record.amount.to_i
        end

        # Add the profit for the current payment record to the corresponding category in the sum_of_category_profit hash
        if sum_of_category_profit.key?(category)
            sum_of_category_profit[category] -= profit_from_current_payment.to_i
        end

        # Add the payment record amount to the trial balance
        trial_balance = trial_balance.to_i
        trial_balance -= payment_record.amount.to_i

        daily_report.update(
            data: {
                date: date,
                report: {
                    payment_statistics: {
                        sum_of_total_payment: sum_of_total_payment,
                        sum_of_category_payment: sum_of_category_payment,
                        sum_of_expenses: sum_of_expenses,
                        trial_balance: trial_balance
                    },
                    profit_statistics: {
                        sum_of_total_profit: sum_of_total_profit,
                        sum_of_category_profit: sum_of_category_profit
                    }
                },
                report_type: 'Daily'
            }
        )

    end
  end
  
