class AddAssignedEmployeeToSubscriptionRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_records, :assigned_employee, :string
  end
end
