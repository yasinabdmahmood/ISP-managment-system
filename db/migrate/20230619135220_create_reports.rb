class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.jsonb :data, null: false, default: '{}'
      t.string :report_type
      t.timestamps
    end
  end
end
