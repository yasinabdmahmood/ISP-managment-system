class PaymentRecord < ApplicationRecord
    belongs_to :subscription_record
    belongs_to :employee
end
  