class SubscriptionRecord < ApplicationRecord

    after_update :update_is_fully_paid

    belongs_to :client
    belongs_to :subscription_type
    belongs_to :employee
    has_many :payment_records, :dependent => :destroy

    validates_associated :payment_records
    validates :pay, presence: true 
    validate :check_for_overpay

    private

    def update_is_fully_paid
        subscription_fee = self.subscription_type.cost
        if subscription_fee == self.pay && self.is_fully_paid !=true
            self.update(is_fully_paid: true)
        end
    end

    def check_for_overpay
        subscription_fee = subscription_type.cost
        if subscription_fee < pay 
            errors.add(:pay, "payment cannot be greater than subscription fee")
        end
    end
    
end  