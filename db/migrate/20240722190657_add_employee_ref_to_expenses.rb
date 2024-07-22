class AddEmployeeRefToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :employee, foreign_key: true
  end
end
