class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :employee_contact_information
    has_many :subscription_records
    has_many :payment_records

    validates_associated :employee_contact_information
    validates_associated :subscription_records
    validates_associated :payment_records
    validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 30 }
    validates :role, presence: true, inclusion: { in: %w(admin employee) }
    
end
