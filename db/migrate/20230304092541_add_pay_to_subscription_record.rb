class AddPayToSubscriptionRecord < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_records, :pay, :decimal
  end
end
