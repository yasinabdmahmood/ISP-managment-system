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

        updated_data = data
        updated_data['report']['payment_statistics']['sum_of_expenses'] = sum_of_expenses.to_i
        updated_data['report']['payment_statistics']['trial_balance'] = trial_balance.to_i
        

        daily_report.update(data: updated_data)
        
    end


    # this function takes the data field of daily report and 
    # returns the reqired fileds specified in the given array for example
    # x,y = extract_report_data(data,[:trial_balance, :sum_of_expenses]) 
    # x will take trial_balnce and y takes sum_of_expenses of daily report
    def extract_daily_report_data(data,requested_fields)
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
  end
  
