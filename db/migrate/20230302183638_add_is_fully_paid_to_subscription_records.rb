class AddIsFullyPaidToSubscriptionRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_records, :is_fully_paid, :boolean
  end
end
