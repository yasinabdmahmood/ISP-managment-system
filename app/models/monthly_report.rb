class MonthlyReport < ApplicationRecord
    has_many :daily_reports
end  