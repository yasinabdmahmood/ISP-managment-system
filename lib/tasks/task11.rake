desc "task11"
# This task updates all the daily and monthly report as well as monthly report
# records and adds sub_type_counter hash to the data field hash of
# corresponding daily and monthly report 
task task11: :environment do

    # report = DailyReport.first
    # data = report.data
    # p data['payment_statistics']
    
      DailyReport.all.each do |daily_report|
      data = daily_report.data
      
      data['report']['sub_type_counter'] = {}

      daily_report.data = data
      if daily_report.save
         p daily_report.data
      else
         p 'fail to update'
      end

      end

      MonthlyReport.all.each do |monthly_report|
        data = monthly_report.data
      
        data['report']['sub_type_counter'] = {}

        monthly_report.data = data
        if monthly_report.save
           p monthly_report.data
        else
           p 'fail to update'
        end

      end
end