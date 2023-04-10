class AddCoordinateToTable < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :coordinate, :string, limit: 30, precision: 15
  end
end
