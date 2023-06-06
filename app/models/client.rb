class Client < ApplicationRecord

    after_create :save_new_record_to_activity
    after_destroy :save_deleted_record_to_activity
    after_update :save_record_changes_to_activity

    has_many :client_contact_informations, dependent: :destroy
    accepts_nested_attributes_for :client_contact_informations
    has_many :subscription_records, dependent: :destroy
    
    validates_associated :client_contact_informations
    validates_associated :subscription_records
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }

    private

    def save_new_record_to_activity
        Activity.create(
            employee_name: Current.employee.name,
            action_type: 'create',
            table_name: 'client',
            json_data: self.to_json
        )
    end

    def save_deleted_record_to_activity
        Activity.create(
            employee_name: Current.employee.name,
            action_type: 'delete',
            table_name: 'client',
            json_data: self.to_json
        )
    end

    def save_record_changes_to_activity
        changes_made = self.saved_changes
        Activity.create(
            employee_name: Current.employee.name,
            action_type: 'update',
            table_name: 'client',
            json_data: changes_made.to_json
        )
    end

    
    
end
