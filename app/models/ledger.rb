class Ledger < ApplicationRecord
   belongs_to :agent

   validate :withdraw_deposit_mismatch_validation, :detail_withdraw_mismatch

   private
   def withdraw_deposit_mismatch_validation

    if withdraw < deposit
      errors.add(:deposit, "can't be greater than withdraw")
    end

    # errors.add(:expiration_date, "can't be in the past")
   end

   def detail_withdraw_mismatch
      sum = 0
      detail.each_value do |value|
        sum+= value
      end

      if sum != withdraw
        errors.add(:withdraw, "some of detail values must be equal to withdraw")
      end

   end
end
