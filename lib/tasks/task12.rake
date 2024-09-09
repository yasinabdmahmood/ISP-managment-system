desc "task12"
# This task deletes all the daily reports that were created after 2024-09-09
 
task task12: :environment do
      date = Time.new(2024, 9, 10)
      records = DailyReport.where('created_at > ?', date)
      records.each do |record|
         record.delete
      end
end