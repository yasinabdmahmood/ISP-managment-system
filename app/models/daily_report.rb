require 'date'
require 'json'

class DailyReport < ApplicationRecord
    belongs_to :monthly_report, optional: true

    after_create :excute_after_daily_report_creation_callbacks

    private

    def excute_after_daily_report_creation_callbacks
        last_monthly_report = MonthlyReport.last
        current_month = self.created_at.month
       
        if last_monthly_report.nil? || last_monthly_report.created_at.month != current_month
            last_monthly_report = create_new_monthly_report
        end

        self.monthly_report = last_monthly_report

        add_current_daily_report_to_monthly_report
    end

    def create_new_monthly_report
        date = self.created_at

        current_monthly_report = MonthlyReport.create(
                data: {
                    date: date,
                    report: {
                        payment_statistics: {
                            sum_of_total_payment: 0,
                            sum_of_category_payment: {}
                        },
                        profit_statistics: {
                            sum_of_total_profit: 0,
                            sum_of_category_profit: {}
                        }
                    },
                },
                created_at: date
        )

        current_monthly_report
    end

    def add_current_daily_report_to_monthly_report
        daily_report = self;
        monthly_report = daily_report.monthly_report
        daily_data = daily_report.data
        monthly_data = monthly_report.data

        daily_sum_of_total_payment = daily_data['report']['payment_statistics']['sum_of_total_payment']
        daily_sum_of_category_payment = daily_data['report']['payment_statistics']['sum_of_category_payment']
        daily_sum_of_total_profit = daily_data['report']['profit_statistics']['sum_of_total_profit']
        daily_sum_of_category_profit = daily_data['report']['profit_statistics']['sum_of_category_profit']

        monthly_sum_of_total_payment = monthly_data['report']['payment_statistics']['sum_of_total_payment']
        monthly_sum_of_category_payment = monthly_data['report']['payment_statistics']['sum_of_category_payment']
        monthly_sum_of_total_profit = monthly_data['report']['profit_statistics']['sum_of_total_profit']
        monthly_sum_of_category_profit = monthly_data['report']['profit_statistics']['sum_of_category_profit']
        monthly_date = monthly_report['data']['date']

        monthly_sum_of_total_payment += daily_sum_of_total_payment
        monthly_sum_of_total_profit += daily_sum_of_total_profit

        monthly_sum_of_category_payment = merge_and_sum_reports(monthly_sum_of_category_payment, daily_sum_of_category_payment)
        monthly_sum_of_category_profit = merge_and_sum_reports(monthly_sum_of_category_profit, daily_sum_of_category_profit)

        monthly_report.update(
                data: {
                    date: monthly_date,
                    report: {
                        payment_statistics: {
                            sum_of_total_payment: monthly_sum_of_total_payment,
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
  
end
