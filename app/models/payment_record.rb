class PaymentRecord < ApplicationRecord
    belongs_to :subscription_record
    belongs_to :employee

    validates :amount, numericality: true, presence: true
end
  