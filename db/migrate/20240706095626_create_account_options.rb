class CreateAccountOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_options do |t|
      t.string :options

      t.timestamps
    end
  end
end
