class ChangeCoordinateColumnTypeInClients < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :coordinate, :string, limit: nil
  end  
end
