class Client < ApplicationRecord
    has_many :client_contact_informations
    has_many :subscription_records

    validates_associated :client_contact_information
    validates_associated :subscription_record
    validates :name, presence: true, length: { minimum: 3, maximum: 30 }
    validates :username, length: { minimum: 3, maximum: 30 }
    
end
