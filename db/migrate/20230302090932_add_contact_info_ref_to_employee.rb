class AddContactInfoRefToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_contact_information, :employee, foreign_key: true
  end
end
