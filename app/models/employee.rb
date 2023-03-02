class Employee < ApplicationRecord
    has_many :employee_contact_informations
    has_many :subscription_records
    has_many :payment_records

    validates_associated :employee_contact_information
    validates_associated :subscription_record
    validates_associated :payment_record
    validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 30 }
    validates :role, presence: true, inclusion: { in: %w(admin employee) }
    
end
