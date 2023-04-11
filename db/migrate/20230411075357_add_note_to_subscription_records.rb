class AddNoteToSubscriptionRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_records, :note, :text
  end
end
