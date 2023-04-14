class AddCostAndSubscriptionTypeToSubscriptionRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_records, :cost, :decimal
    add_column :subscription_records, :category, :string

    # Set values for new columns based on associated subscription_type
    # SubscriptionRecord.all.each do |record|
    #   record.update(cost: record.subscription_type.cost, category: record.subscription_type.category)
    # end
  end
end
