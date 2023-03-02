class CreateCreateSubscriptionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_types do |t|
      t.string :category
      t.decimal :cost
      t.decimal :profit

      t.timestamps
    end
  end
end
