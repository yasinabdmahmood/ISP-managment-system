class Client < ApplicationRecord

    after_create :add_client_to_activity

    has_many :client_contact_informations, dependent: :destroy
    accepts_nested_attributes_for :client_contact_informations
    has_many :subscription_records, dependent: :destroy
    
    validates_associated :client_contact_informations
    validates_associated :subscription_records
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }

    private

    def add_client_to_activity
        Activity.create(
            employee_name: self.name,
            action_type: 'create',
            table_name: 'client',
            json_data: self.to_json
        )
    end

    
    
end
