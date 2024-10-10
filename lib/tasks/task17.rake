desc "task17"
# Set the date column for daily_reports and monthly_reports to the created_at date
# for all the records in both table daily_reports and monthly_reports

 
task task17: :environment do
    def create_empty_record(type,date)
        # this method creates a new daily report for the given payment date
        data =  {
            date: date.to_s,
            report: {
                sub_type_counter: {},
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
        }
        if type === 'daily_report' 
            return DailyReport.create(date: date, data: data)
        end
        if type === 'monthly_report'
            return MonthlyReport.create(date: date.beginning_of_month, data: data)
        end
    end 

    def add_daily_report_to_monthly_report(daily_report, monthly_report)
        daily_report.monthly_report = monthly_report

        daily_data = daily_report.data


        monthly_data = monthly_report.data
        

        daily_sum_of_total_payment = daily_data['report']['payment_statistics']['sum_of_total_payment']
        daily_sum_of_expense = daily_data['report']['payment_statistics']['sum_of_expenses']
        daily_trial_balance = daily_data['report']['payment_statistics']['trial_balance']
        daily_sum_of_category_payment = daily_data['report']['payment_statistics']['sum_of_category_payment']
        daily_sum_of_total_profit = daily_data['report']['profit_statistics']['sum_of_total_profit']
        daily_sum_of_category_profit = daily_data['report']['profit_statistics']['sum_of_category_profit']
        daily_sub_type_counter = daily_data['report']['sub_type_counter']

        monthly_sum_of_total_payment = monthly_data['report']['payment_statistics']['sum_of_total_payment']
        monthly_sum_of_expenses = monthly_data['report']['payment_statistics']['sum_of_expenses']
        monthly_trial_balance = monthly_data['report']['payment_statistics']['trial_balance']
        monthly_sum_of_category_payment = monthly_data['report']['payment_statistics']['sum_of_category_payment']
        monthly_sum_of_total_profit = monthly_data['report']['profit_statistics']['sum_of_total_profit']
        monthly_sum_of_category_profit = monthly_data['report']['profit_statistics']['sum_of_category_profit']
        monthly_sub_type_counter = monthly_data['report']['sub_type_counter']
        monthly_date = monthly_report['data']['date']
        # byebug
        monthly_sum_of_total_payment += daily_sum_of_total_payment
        monthly_sum_of_total_profit += daily_sum_of_total_profit
        monthly_sum_of_expenses += daily_sum_of_expense
        monthly_trial_balance += daily_trial_balance
        
        monthly_sum_of_category_payment = merge_and_sum_reports(monthly_sum_of_category_payment, daily_sum_of_category_payment)
        monthly_sum_of_category_profit = merge_and_sum_reports(monthly_sum_of_category_profit, daily_sum_of_category_profit)
        monthly_sub_type_counter = merge_and_sum_reports(monthly_sub_type_counter, daily_sub_type_counter)

        monthly_report.update(
                data: {
                    date: monthly_date,
                    report: {
                        sub_type_counter: monthly_sub_type_counter,
                        payment_statistics: {
                            sum_of_total_payment: monthly_sum_of_total_payment,
                            sum_of_expenses: monthly_sum_of_expenses,
                            trial_balance: monthly_trial_balance,
                            sum_of_category_payment: monthly_sum_of_category_payment
                        },
                        profit_statistics: {
                            sum_of_total_profit: monthly_sum_of_total_profit,
                            sum_of_category_profit: monthly_sum_of_category_profit
                        }
                    },
                }
        )
    end

    def merge_and_sum_reports(hash1, hash2)
        result = {}
    
        hash1.each do |key, value|
        result[key] = value
        end
    
        hash2.each do |key, value|
        result[key] ||= 0 # Initialize to 0 if the key doesn't exist in hash1
        result[key] += value
        end
    
        result
    end

    start_date = Date.parse('2024-10-01')
    end_date = Date.parse('2024-10-10')



    (start_date..end_date).each do |date|
        daily_report = DailyReport.find_by(date: date)
        monthly_report = MonthlyReport.find_by(date: date.beginning_of_month)
        if monthly_report.nil?
            monthly_report = create_empty_record('monthly_report', date.beginning_of_month)
            p monthly_report
        end
        add_daily_report_to_monthly_report(daily_report, monthly_report) if !daily_report.nil?

    end
    
 

end

