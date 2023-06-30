class SubscriptionType < ApplicationRecord
    
    has_many :subscription_records
    
    validates_associated :subscription_records
    validates :category, presence: true, uniqueness: true
    validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :profit, presence: true, numericality: { greater_than_or_equal_to: 0 }

    after_create :save_new_record_to_activity
    after_destroy :save_deleted_record_to_activity
    after_update :save_record_changes_to_activity

    private

        def save_new_record_to_activity
            json_data = {
                category: self.category,
                cost: self.cost,
                profit: self.profit,
                created_at: self.created_at,
                updated_at: self.updated_at,
            }
            create_activity_record(action_type: 'create' ,table_name: 'subscription type' ,json_data: json_data)
            
        end

        def save_deleted_record_to_activity
            json_data = {
                category: self.category,
                cost: self.cost,
                profit: self.profit,
                created_at: self.created_at,
                updated_at: self.updated_at,
            }
            create_activity_record(action_type: 'delete' ,table_name: 'subscription type' ,json_data: json_data)
            # Activity.create(
            #     employee_name: Current.employee.name,
            #     action_type: 'delete',
            #     table_name: 'client',
            #     json_data: self.to_json
            # )
        end

        def save_record_changes_to_activity
            changes_made = self.saved_changes
            json_data = {
                category: self.category,
                cost: self.cost,
                profit: self.profit,
                created_at: self.created_at,
                updated_at: self.updated_at,
            }
            merged_hash = json_data.merge(changes_made)
            create_activity_record(action_type: 'update' ,table_name: 'subscription type' ,json_data: changes_made)
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
