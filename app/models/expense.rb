class Expense < ApplicationRecord
    belongs_to :account_option
    belongs_to :employee

    validates :amount, presence: true, numericality: true
    validates :date, presence: true
    validates :remark, presence: true
    validates :status, presence: true, inclusion: { in: %w[pending rejected approved] }
end
