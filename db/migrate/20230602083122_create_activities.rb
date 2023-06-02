class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :employee_name
      t.string :action_type
      t.string :table_name
      t.text :json_data

      t.timestamps
    end
  end
end
