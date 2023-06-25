class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :employee_contact_information
    has_many :subscription_records
    has_many :payment_records

    validates_associated :employee_contact_information
    validates_associated :subscription_records
    validates_associated :payment_records
    validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 30 }
    validates :role, presence: true, inclusion: { in: %w(admin employee) }

    # after_create :save_new_record_to_activity
    # after_destroy :save_deleted_record_to_activity
    # after_update :save_record_changes_to_activity

    # private

    # def save_new_record_to_activity
    #     json_data = {
    #       name: self.name,
    #       email: self.email,
    #       role: self.role,
    #       created_at: self.created_at,
    #       updated_at: self.updated_at
    #     }
    #     create_activity_record(action_type: 'create' ,table_name: 'Employee' ,json_data: json_data)
    #     # Activity.create(
    #     #     employee_name: Current.employee.name,
    #     #     action_type: 'create',
    #     #     table_name: 'client',
    #     #     json_data: self.to_json
    #     # )
    # end

    # def save_deleted_record_to_activity
    #     json_data = {
    #       name: self.name,
    #       email: self.email,
    #       role: self.role,
    #       created_at: self.created_at,
    #       updated_at: self.updated_at
    #     }
    #     create_activity_record(action_type: 'delete' ,table_name: 'Employee' ,json_data: json_data)
    #     # Activity.create(
    #     #     employee_name: Current.employee.name,
    #     #     action_type: 'delete',
    #     #     table_name: 'client',
    #     #     json_data: self.to_json
    #     # )
    # end

    # def save_record_changes_to_activity
    #     changes_made = self.saved_changes
    #     json_data = {
    #       name: self.name,
    #       email: self.email,
    #       role: self.role,
    #       created_at: self.created_at,
    #       updated_at: self.updated_at
    #     }
    #     merged_hash = json_data.merge(changes_made)
    #     create_activity_record(action_type: 'update' ,table_name: 'Employee' ,json_data: merged_hash)
    # end

    # def create_activity_record( action_type: ,table_name: ,json_data: )
    #     Activity.create(
    #         employee_name: Current.employee.name,
    #         action_type: action_type,
    #         table_name: table_name,
    #         json_data: json_data.to_json
    #     )
    # end
    
end
