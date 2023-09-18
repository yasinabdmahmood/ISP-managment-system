class CreateMonthlyReports < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_reports do |t|
      t.jsonb :data
      t.timestamps
    end
  end
end
