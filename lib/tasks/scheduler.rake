desc "test_report"
require 'date'
task test_report: :environment do
    today = DateTime.now
    todays_report = DailyReport.create(
        data: {
            date: today,
            some_dummy_data: ['alex','sam','john'],
            report_type: 'Daily'
        }
    )

    # monthly report
    current_month = Date.today.month
    last_record = DailyReport.last

    if !last_record || last_record.created_at.month != current_month
        todays_report = DailyReport.create(
        data: {
            date: today,
            some_dummy_data: ['alex','sam','john'],
            report_type: 'Monthly'
        }
    )
    end
end