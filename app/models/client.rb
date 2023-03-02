class Client < ApplicationRecord
    has_many :client_contact_informations
    has_many :subscription_records
end
