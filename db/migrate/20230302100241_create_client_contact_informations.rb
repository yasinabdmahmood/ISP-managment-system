class CreateClientContactInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :client_contact_informations do |t|
      t.string :contact_information
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
