class SubscriptionRecord < ApplicationRecord
    include Report
    
    before_create :set_actual_creation_time_to_current_time
    before_destroy :check_if_deletable
    after_create :excute_after_sub_record_creation_callbacks
    after_destroy :excute_after_sub_record_deletion_callbacks
    after_update :save_record_changes_to_activity
    # before_update :restrict_assigned_employee_updates_for_non_admins, :restrict_created_at_updates_for_non_admins
    before_update :restrict_field_updates_for_non_admins
    after_update :update_is_fully_paid

    belongs_to :client
    belongs_to :subscription_type
    belongs_to :employee
    has_many :payment_records, :dependent => :destroy

    validates_associated :payment_records
    validates :pay, presence: true 
    validate :check_for_overpay

    private

    def restrict_field_updates_for_non_admins
        if Current.employee.role == 'employee'
          # Only allow updating the `info` column.
          # Revert changes to all other columns except `info`.
          self.assigned_employee = assigned_employee_was if assigned_employee_changed?
          self.created_at = created_at_was if created_at_changed?
          # Add any other columns you want to restrict here
        end
    end

    # def restrict_assigned_employee_updates_for_non_admins
    #     if Current.employee.role == 'employee' && self.assigned_employee_changed?
    #         errors.add(:base, "Only admins can update assigned employee")
    #         p "Only admins can update assigned employee"
    #         throw(:abort)
    #     end
    # end

    # def restrict_created_at_updates_for_non_admins
    #     if Current.employee.role == 'employee' && self.created_at_changed?
    #         errors.add(:base, "Only admins can update created_at field")
    #         p "Only admins can update assigned employee"
    #         throw(:abort)
    #     end
    # end

    def check_if_deletable  
        if self.actual_creation_time.to_date != Time.zone.now.to_date   
            errors.add(:base, "Cannot delete payment record from previous days")    
            throw(:abort)
        end
    end

    def set_actual_creation_time_to_current_time    
        self.actual_creation_time = Time.zone.now
    end

    def excute_after_sub_record_creation_callbacks

        save_new_record_to_activity

        update_daily_report(self,'add_sub_record')
        update_monthly_report(self,'add_sub_record')

    end

    def excute_after_sub_record_deletion_callbacks
        save_deleted_record_to_activity
        update_daily_report(self,'delete_sub_record')
        update_monthly_report(self,'delete_sub_record')
    end

    def update_daily_report(sub_record,action)
        today = Time.zone.now.to_date
        daily_report = DailyReport.last
        daily_report = create_empty_record('daily_report',Time.zone.now.to_date) if daily_report.created_at.to_date != today
        add_subscription_to_report(daily_report,sub_record) if action == 'add_sub_record'
        remove_subscription_from_report(daily_report,sub_record) if action == 'delete_sub_record'
    end

    def update_monthly_report(sub_record,action)
        date = sub_record.actual_creation_time.to_date
        monthly_report = MonthlyReport.find_by(date: date.beginning_of_month)
        monthly_report = create_empty_record('monthly_report',date.beginning_of_month) if monthly_report.nil?
        add_subscription_to_report(monthly_report,sub_record) if action == 'add_sub_record'
        remove_subscription_from_report(monthly_report,sub_record) if action == 'delete_sub_record'
    end

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