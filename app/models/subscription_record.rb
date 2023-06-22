class SubscriptionRecord < ApplicationRecord

    after_create :save_new_record_to_activity
    after_destroy :save_deleted_record_to_activity
    after_update :save_record_changes_to_activity

    after_update :update_is_fully_paid

    belongs_to :client
    belongs_to :subscription_type
    belongs_to :employee
    has_many :payment_records, :dependent => :destroy

    validates_associated :payment_records
    validates :pay, presence: true 
    validate :check_for_overpay

    private

    def update_is_fully_paid
        subscription_fee = self.subscription_type.cost
        if subscription_fee == self.pay && self.is_fully_paid !=true
            self.update(is_fully_paid: true)
        end
    end

    def check_for_overpay
        subscription_fee = subscription_type.cost
        if subscription_fee < pay 
            errors.add(:pay, "payment cannot be greater than subscription fee")
        end
    end



    def save_new_record_to_activity
        json_data = {
            user: self.client.name,
            username: self.client.username,
            employee: self.employee.name,
            assigned_employee: self.assigned_employee,
            category: self.category,
            cost: self.cost,
            pay: self.pay,
            note: self.note,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'create' ,table_name: 'Subscription Record' ,json_data: json_data)
    end

    def save_deleted_record_to_activity
        json_data = {
            user: self.client.name,
            username: self.client.username,
            employee: self.employee.name,
            assigned_employee: self.assigned_employee,
            category: self.category,
            cost: self.cost,
            pay: self.pay,
            note: self.note,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'delete' ,table_name: 'Subscription Record' ,json_data: json_data)
    end

    def save_record_changes_to_activity
        changes_made = self.saved_changes
        json_data = {
            user: self.client.name,
            username: self.client.username,
            employee: self.employee.name,
            assigned_employee: self.assigned_employee,
            category: self.category,
            cost: self.cost,
            pay: self.pay,
            note: self.note,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        merged_hash = json_data.merge(changes_made)
        create_activity_record(action_type: 'update' ,table_name: 'Subscription Record' ,json_data: merged_hash)
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