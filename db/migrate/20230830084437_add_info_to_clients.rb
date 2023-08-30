class AddInfoToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :info, :text
  end
end
