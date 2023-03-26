class PaymentRecord < ApplicationRecord
    # after_create :update_associated_subscription_record

    validate :check_for_overpay
    

    belongs_to :subscription_record
    belongs_to :employee

    validates :amount, numericality: true, presence: true

    private

    def check_for_overpay
        subscription_fee = self.subscription_record.subscription_type.cost
        if self.subscription_record.pay > subscription_fee
            errors.add(:amount, "cannot be greater than subscription fee")
        end
    end

    # def update_associated_subscription_record
    #     sr = self.subscription_record
    #     amount = self.amount
    #     subscription_fee = sr.subscription_type.cost
    #     if amount + sr.pay == subscription_fee
    #       sr.update(is_fully_paid: true)
    #     end
    #     sr.update(pay: sr.pay + amount)
    # end
      
end
  