class Client < ApplicationRecord
    has_many :client_contact_informations
    has_many :subscription_records

    validates_associated :client_contact_informations
    validates_associated :subscription_records
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
    
end
