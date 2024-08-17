require 'date'
require 'json'

class PaymentRecord < ApplicationRecord
    include Report
    # after_create :update_associated_subscription_record

    after_create :excute_after_payment_record_creation_callbacks
    after_destroy :excute_after_payment_record_deletion_callbacks
    # after_destroy :save_deleted_record_to_activity

    validate :check_for_overpay
    

    belongs_to :subscription_record
    belongs_to :employee

    validates :amount, numericality: true, presence: true

    private

    def excute_after_payment_record_creation_callbacks

        save_new_record_to_activity

        update_daily_report

    end

    def excute_after_payment_record_deletion_callbacks
        save_deleted_record_to_activity
        remove_current_payment_from_daily_report(self)
    end

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

    def save_new_record_to_activity
        json_data = {
            employee: self.employee.name,
            user: self.subscription_record.client.name,
            amount: self.amount,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'create' ,table_name: 'payment' ,json_data: json_data)
    end

    # create_table "daily_reports", force: :cascade do |t|
    #     t.jsonb "data"
    #     t.datetime "created_at", null: false
    #     t.datetime "updated_at", null: false
    # end

    # {
    #     "data": {
    #         "date": "today",
    #         "report": {
    #         "payment_statistics": {
    #             "sum_of_total_payment": "sum_of_total_payment",
    #             "sum_of_category_payment": "sum_of_category_payment"
    #         },
    #         "profit_statistics": {
    #             "sum_of_total_profit": "sum_of_total_profit",
    #             "sum_of_category_profit": "sum_of_category_profit"
    #         }
    #         },
    #         "report_type": "Daily"
    #     }
    # }

    def update_daily_report
        payment_date = self.created_at.to_date
        daily_report = DailyReport.find_by(created_at: payment_date.beginning_of_day..payment_date.end_of_day)
        daily_report = create_empty_daily_record_for_current_payment(payment_date) if daily_report.nil?
        add_current_payment_to_belonged_daily_report(daily_report,self)
    end

    def save_deleted_record_to_activity
        json_data = {
            employee: self.employee.name,
            user: self.subscription_record.client.name,
            amount: self.amount,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'delete' ,table_name: 'payment' ,json_data: json_data)
    end


    def create_activity_record( action_type: ,table_name: ,json_data: )
        Activity.create(
            employee_name: Current.employee.name,
            action_type: action_type,
            table_name: table_name,
            json_data: json_data.to_json
        )
    end

end
  