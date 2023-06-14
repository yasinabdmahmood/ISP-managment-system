class PaymentRecord < ApplicationRecord
    # after_create :update_associated_subscription_record

    after_create :save_new_record_to_activity
    after_destroy :save_deleted_record_to_activity

    validate :check_for_overpay
    

    belongs_to :subscription_record
    belongs_to :employee

    validates :amount, numericality: true, presence: true

    private

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

    def save_deleted_record_to_activity
        json_data = {
            employee: self.employee.name,
            user: self.subscription_record.client.name,
            amount: self.amount,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'delete' ,table_name: 'payment' ,json_data: json_data)
        # Activity.create(
        #     employee_name: Current.employee.name,
        #     action_type: 'delete',
        #     table_name: 'client',
        #     json_data: self.to_json
        # )
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
  