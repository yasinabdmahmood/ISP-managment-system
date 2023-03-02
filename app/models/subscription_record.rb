class SubscriptionRecord < ApplicationRecord
    belongs_to :client
    belongs_to :subscription_type
    belongs_to :employee
end  