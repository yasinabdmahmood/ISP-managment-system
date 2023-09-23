class AddMonthlyReportToDailyReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :daily_reports, :monthly_report, foreign_key: true
  end
end
