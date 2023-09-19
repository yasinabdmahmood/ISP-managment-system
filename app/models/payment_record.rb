require 'date'
require 'json'

class PaymentRecord < ApplicationRecord

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
        remove_current_payment_from_daily_report
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
        latest_record = DailyReport.last

        if latest_record && latest_record.created_at.to_date == Date.today
          # The last record was created today
          add_current_payment_to_daily_report
          puts "The last record was created today."
        else
            # The last record was not created today or there are no records in the table
            create_empty_daily_record_for_today
            
            add_current_payment_to_daily_report
            puts "The last record was not created today or there are no records in the table."
        end
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

    def add_current_payment_to_daily_report

        subscription_types = SubscriptionType.all
        # Initialize an empty hash
        category_profit_hash = {}
        # Iterate through the SubscriptionTypes
        subscription_types.each do |subscription_type|
            # Use the category as the key and profit as the value and store it in the hash table
            category_profit_hash[subscription_type.category] = subscription_type.profit
        end

        daily_report = DailyReport.last;
        data = daily_report.data

        sum_of_total_payment = data['report']['payment_statistics']['sum_of_total_payment']
        sum_of_category_payment = data['report']['payment_statistics']['sum_of_category_payment']
        sum_of_total_profit = data['report']['profit_statistics']['sum_of_total_profit']
        sum_of_category_profit = data['report']['profit_statistics']['sum_of_category_profit']
        date = data['date']
        payment_record = self
        # Get the category to which the current payment record belongs 
        category = payment_record.subscription_record.subscription_type.category

        # Add payment_record.amount to the sum_of_total_payment
        sum_of_total_payment += payment_record.amount.to_i

        p 'ooooooooooooooooooooooooooo'
        p category
        p category_profit_hash
        #calculate the profit for the current payment_record
        profit_from_current_payment = (category_profit_hash[category]*(payment_record.amount / payment_record.subscription_record.cost)).to_i

        # Add the calculated profit to the sum_of_total_profit
        sum_of_total_profit += profit_from_current_payment
   
        # Add the payment record amount to the corresponding category in the sum_of_category_payment hash
        if sum_of_category_payment.key?(category)
            sum_of_category_payment[category] += payment_record.amount.to_i
        else
            sum_of_category_payment[category] = payment_record.amount.to_i
        end

        # Add the profit for the current payment record to the corresponding category in the sum_of_category_profit hash
        if sum_of_category_profit.key?(category)
            sum_of_category_profit[category] += profit_from_current_payment.to_i
        else
            sum_of_category_profit[category] = profit_from_current_payment.to_i
        end

        daily_report.update(
            data: {
                date: date,
                report: {
                    payment_statistics: {
                        sum_of_total_payment: sum_of_total_payment,
                        sum_of_category_payment: sum_of_category_payment
                    },
                    profit_statistics: {
                        sum_of_total_profit: sum_of_total_profit,
                        sum_of_category_profit: sum_of_category_profit
                    }
                },
                report_type: 'Daily'
            }
        )

    end

    def create_empty_daily_record_for_today
        today = DateTime.now

        todays_report = DailyReport.create(
                data: {
                    date: today,
                    report: {
                        payment_statistics: {
                            sum_of_total_payment: 0,
                            sum_of_category_payment: {}
                        },
                        profit_statistics: {
                            sum_of_total_profit: 0,
                            sum_of_category_profit: {}
                        }
                    },
                    report_type: 'Daily'
                }
        )
    end 

    def remove_current_payment_from_daily_report
        payment_record = self
        payment_date = payment_record.created_at.to_date
  
        daily_report = DailyReport.find_by(created_at: payment_date.beginning_of_day..payment_date.end_of_day)


        data = daily_report.data

        sum_of_total_payment = data['report']['payment_statistics']['sum_of_total_payment']
        sum_of_category_payment = data['report']['payment_statistics']['sum_of_category_payment']
        sum_of_total_profit = data['report']['profit_statistics']['sum_of_total_profit']
        sum_of_category_profit = data['report']['profit_statistics']['sum_of_category_profit']
        date = data['date']

        subscription_types = SubscriptionType.all
        # Initialize an empty hash
        category_profit_hash = {}
        # Iterate through the SubscriptionTypes
        subscription_types.each do |subscription_type|
            # Use the category as the key and profit as the value and store it in the hash table
            category_profit_hash[subscription_type.category] = subscription_type.profit
        end

        # Get the category to which the current payment record belongs 
        category = payment_record.subscription_record.subscription_type.category

        # Add payment_record.amount to the sum_of_total_payment
        sum_of_total_payment -= payment_record.amount.to_i


        #calculate the profit for the current payment_record
        profit_from_current_payment = (category_profit_hash[category]*(payment_record.amount / payment_record.subscription_record.cost)).to_i

        # Add the calculated profit to the sum_of_total_profit
        sum_of_total_profit -= profit_from_current_payment
   
        # Add the payment record amount to the corresponding category in the sum_of_category_payment hash
        if sum_of_category_payment.key?(category)
            sum_of_category_payment[category] -= payment_record.amount.to_i
        end

        # Add the profit for the current payment record to the corresponding category in the sum_of_category_profit hash
        if sum_of_category_profit.key?(category)
            sum_of_category_profit[category] -= profit_from_current_payment.to_i
        end

        daily_report.update(
            data: {
                date: date,
                report: {
                    payment_statistics: {
                        sum_of_total_payment: sum_of_total_payment,
                        sum_of_category_payment: sum_of_category_payment
                    },
                    profit_statistics: {
                        sum_of_total_profit: sum_of_total_profit,
                        sum_of_category_profit: sum_of_category_profit
                    }
                },
                report_type: 'Daily'
            }
        )

        
        
        if daily_report
          # Do something with the found daily_report
        else
          # Handle the case where no matching daily_report is found
        end
    end
      
  
end
  