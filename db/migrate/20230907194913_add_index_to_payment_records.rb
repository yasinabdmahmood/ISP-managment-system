class AddIndexToPaymentRecords < ActiveRecord::Migration[7.0]
  def change
    add_index :payment_records, :created_at
  end
end
