class CreateEmployeeContactInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_contact_informations do |t|
      t.string :contact_info

      t.timestamps
    end
  end
end
