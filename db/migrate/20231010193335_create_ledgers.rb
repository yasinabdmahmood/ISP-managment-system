class CreateLedgers < ActiveRecord::Migration[6.0]
  def change
    create_table :ledgers do |t|
      t.references :agent, foreign_key: true, index: true
      t.date :date
      t.integer :withdraw
      t.integer :deposit
      t.json :detail

      t.timestamps
    end

    add_index :ledgers, :date
  end
end
