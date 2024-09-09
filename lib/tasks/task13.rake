desc "task13"
# This task deletes all the daily reports that were created after 2024-09-09
 
task task13: :environment do
    DailyReport.all.each do |daily_report|
        data = daily_report.data
        data['report']['payment_statistics']['sum_of_total_payment'] = 0 if data.dig('report', 'payment_statistics', 'sum_of_total_payment').nil?
        data['report']['payment_statistics']['sum_of_category_payment'] = {} if data.dig('report', 'payment_statistics', 'sum_of_category_payment').nil?
        data['report']['payment_statistics']['sum_of_expenses'] = 0 if data.dig('report', 'payment_statistics', 'sum_of_expenses').nil?
        data['report']['payment_statistics']['trial_balance'] = 0 if data.dig('report', 'payment_statistics', 'trial_balance').nil?
        data['report']['profit_statistics']['sum_of_total_profit'] = 0 if data.dig('report', 'profit_statistics', 'sum_of_total_profit').nil?     
        data['report']['profit_statistics']['sum_of_category_profit'] = {} if data.dig('report', 'profit_statistics', 'sum_of_category_profit').nil?
        data['report']['sub_type_counter'] = {} if data.dig('report', 'sub_type_counter').nil?
        daily_report.data = data
        if daily_report.save
           p daily_report.data
        else
           p 'fail to update'
      end
end
