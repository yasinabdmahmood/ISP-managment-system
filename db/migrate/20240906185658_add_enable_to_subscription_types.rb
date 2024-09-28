class AddEnableToSubscriptionTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_types, :enable, :boolean, default: true
  end
end
