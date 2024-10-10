desc "task16"
# Set the date column for daily_reports and monthly_reports to the created_at date
# for all the records in both table daily_reports and monthly_reports

 
task task16: :environment do
    DailyReport.all.each do |daily_report|
        daily_report.date = daily_report.created_at.to_date
        daily_report.save
    end

    MonthlyReport.all.each do |monthly_report|
        monthly_report.date = monthly_report.created_at.to_date
        monthly_report.save
    end
    
end
# for all the records in both table payment_records and subscription_records
# if thier value is nil
 
task task16: :environment do
    PaymentRecord.where(actual_creation_time: nil).update_all('actual_creation_time = created_at')
    SubscriptionRecord.where(actual_creation_time: nil).update_all('actual_creation_time = created_at')

end
