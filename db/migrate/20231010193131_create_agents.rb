class CreateAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :agents do |t|
      t.string :name, unique: true  # Add the unique constraint here
      t.text :info

      t.timestamps
    end
  end
end
