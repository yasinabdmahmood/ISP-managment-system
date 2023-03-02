class CreateClientContactInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :client_contact_information do |t|
      t.string :contact_info
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
