class Client < ApplicationRecord
    has_many :client_contact_informations, dependent: :destroy
    accepts_nested_attributes_for :client_contact_informations
    has_many :subscription_records, dependent: :destroy
    
    validates :coordinate, format: { with: /\A-?\d+(?:\.\d+)?,-?\d+(?:\.\d+)?\z/, message: "must be a valid GPS coordinate" }
    validates_associated :client_contact_informations
    validates_associated :subscription_records
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
    
end
