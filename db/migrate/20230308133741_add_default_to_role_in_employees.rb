class AddDefaultToRoleInEmployees < ActiveRecord::Migration[7.0]
  def change
    change_column :employees, :role, :string, default: "employee"
  end
end
