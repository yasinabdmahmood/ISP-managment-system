class SubscriptionRecord < ApplicationRecord
    belongs_to :client
    belongs_to :subscription_type
    belongs_to :employee
    has_many :payment_records

    validates_associated :payment_records
    validates :pay, presence: true 
    
end  