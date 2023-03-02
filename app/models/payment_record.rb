class PaymentRecord < ApplicationRecord
    belongs_to :subscription_record
    belongs_to :employee

    validates_associated :subscription_record
    validates_associated :employee
    validates :amount, numericality: true, presence: true
end
  