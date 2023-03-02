class CreatePaymentRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_records do |t|
      t.references :subscription_record, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
