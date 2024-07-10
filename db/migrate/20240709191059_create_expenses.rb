class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.date :date
      t.string :remark
      t.string :status
      t.references :account_option, foreign_key: true
      t.timestamps
    end
  end
end
