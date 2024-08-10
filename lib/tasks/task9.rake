desc "task9"
# This task updates all the daily and monthly report as well as monthly report
# records and adds sum_of_expenses and trial_balance key the data field hash of
# corresponding daily and monthly report 
task task9: :environment do

    # report = DailyReport.first
    # data = report.data
    # p data['payment_statistics']
    
      DailyReport.all.each do |daily_report|
      data = daily_report.data
      
      data['report']['payment_statistics']['trial_balance'] = 0
      data['report']['payment_statistics']['sum_of_expenses'] = 0

      daily_report.data = data
      if daily_report.save
         p daily_report.data
      else
         p 'fail to update'
      end

      end

      MonthlyReport.all.each do |monthly_report|
        data = monthly_report.data
      
        data['report']['payment_statistics']['trial_balance'] = 0
        data['report']['payment_statistics']['sum_of_expenses'] = 0

        monthly_report.data = data
        if monthly_report.save
           p monthly_report.data
        else
           p 'fail to update'
        end

      end
end