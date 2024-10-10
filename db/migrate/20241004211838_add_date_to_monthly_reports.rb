class AddDateToMonthlyReports < ActiveRecord::Migration[7.0]
  def change
    add_column :monthly_reports, :date, :date
    add_index :monthly_reports, :date, unique: true
  end
end
