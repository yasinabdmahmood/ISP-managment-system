desc "test_report"
require 'date'
task test_report: :environment do
    today = DateTime.now
    todays_report = DailyReport.create(
        data: {
            date: today,
            some_dummy_data: ['alex','sam','john']
        }
    )
end