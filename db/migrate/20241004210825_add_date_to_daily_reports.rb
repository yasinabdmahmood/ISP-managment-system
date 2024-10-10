class AddDateToDailyReports < ActiveRecord::Migration[7.0]
  def change
    add_column :daily_reports, :date, :date
    add_index :daily_reports, :date, unique: true
  end
end
