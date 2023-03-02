class Employee < ApplicationRecord
    has_many :employee_contact_informations
    has_many :subscription_records
    has_many :payment_records
    
end
