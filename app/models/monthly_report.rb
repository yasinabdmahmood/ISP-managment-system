class MonthlyReport < ApplicationRecord
    has_many :daily_reports
    validates :date, presence: true, uniqueness: true
    validate :validate_year_month

    def validate_year_month
      day = self.date.day
      errors.add(:date, "must be first day of the month") if day != 1
    end
end  