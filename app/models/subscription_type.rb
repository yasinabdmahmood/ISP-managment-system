class SubscriptionType < ApplicationRecord
    
    has_many :subscription_records
    
    validates_associated :subscription_records
    validates :category, presence: true, uniqueness: true
    validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :profit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
