class DailyReport < ApplicationRecord
    belongs_to :monthly_report, optional: true
end
