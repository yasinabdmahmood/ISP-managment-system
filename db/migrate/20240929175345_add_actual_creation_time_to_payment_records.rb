class AddActualCreationTimeToPaymentRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_records, :actual_creation_time, :datetime
  end
end
