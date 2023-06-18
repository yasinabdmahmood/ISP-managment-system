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
        json_data = {
            name: self.name,
            username: self.username,
            coordinate: self.coordinate,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'create' ,table_name: 'client' ,json_data: json_data)
    end

    def save_deleted_record_to_activity
        json_data = {
            name: self.name,
            username: self.username,
            coordinate: self.coordinate,
            created_at: self.created_at,
            updated_at: self.updated_at,
        }
        create_activity_record(action_type: 'delete' ,table_name: 'client' ,json_data: json_data)
    end

    def save_record_changes_to_activity
        changes_made = self.saved_changes
        json_data = {
                name: self.name,
                username: self.username,
                coordinate: self.coordinate,
                created_at: self.created_at,
                updated_at: self.updated_at,
        }
        merged_hash = json_data.merge(changes_made)
        create_activity_record(action_type: 'update' ,table_name: 'client' ,json_data: merged_hash)
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
