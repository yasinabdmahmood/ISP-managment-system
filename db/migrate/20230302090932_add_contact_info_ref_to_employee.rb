class AddContactInfoRefToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_contact_informations, :employees, foreign_key: true
  end
end
