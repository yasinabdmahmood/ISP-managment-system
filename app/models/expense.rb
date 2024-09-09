require 'date'
class Expense < ApplicationRecord
    include Report
    belongs_to :account_option
    belongs_to :employee

    after_update  :update_daily_report

    validates :amount, presence: true, numericality: true
    validates :date, presence: true
    validates :remark, presence: false
    validates :status, presence: true, inclusion: { in: %w[pending rejected approved] }
    validate :must_have_corresponding_daily_report, on: :update
    validate :amount_must_not_be_greator_than_trial_balance, on: :update
    

    private

    def must_have_corresponding_daily_report
        if status_changed? && status == 'approved'
            expense_date = Time.zone.now
            daily_report = DailyReport.find_by(created_at: expense_date.beginning_of_day..expense_date.end_of_day)
            errors.add(:amount, "No corresponding daily report for this expense") if daily_report.nil?
        end
    end

    def amount_must_not_be_greator_than_trial_balance
        if status_changed? && status == 'approved'
            expense_date = Time.zone.now
            daily_report = DailyReport.find_by(created_at: expense_date.beginning_of_day..expense_date.end_of_day)
            trial_balance = daily_report.data['report']['payment_statistics']['trial_balance'] rescue nil
            errors.add(:amount, "Expense Amount must not be greator than trial balance") if !trial_balance.nil? && trial_balance < self.amount
        end
       
    end

    def update_daily_report
        if saved_change_to_status? && status == 'approved'
            expense_date = Time.zone.now
            # daily_report = DailyReport.find_by(created_at: expense_date.beginning_of_day..expense_date.end_of_day)
            daily_report = DailyReport.last
            daily_report_date = daily_report.created_at.to_date
            if daily_report_date == expense_date.to_date
            add_current_expense_to_belonged_daily_report(self,daily_report) if daily_report.present?
            end
        end
    end

end
