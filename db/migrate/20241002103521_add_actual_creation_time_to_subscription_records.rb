class AddActualCreationTimeToSubscriptionRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_records, :actual_creation_time, :datetime
  end
end
