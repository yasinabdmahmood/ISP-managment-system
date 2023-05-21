require 'csv'
class BackupsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def download_subscription_types_as_csv
    # Retrieve data from the database
    data = SubscriptionType.all

    # Generate CSV data
    csv_data = CSV.generate do |csv|
      # Write headers
      csv << ['Category', 'Cost', 'Profit']

      # Write data rows
      data.each do |row|
        csv << [row.category, row.cost, row.profit]
      end
    end

    # Send the CSV file as a response
    send_data csv_data, filename: 'subscription_types.csv', type: 'text/csv'
  end
  
  def download_subscription_records_as_csv
    # Retrieve data from the database
    subscription_records = SubscriptionRecord.includes(:client, :employee, :subscription_type).all

    # Generate CSV data
    csv_data = CSV.generate(encoding: 'UTF-8') do |csv|
      # Write headers
      csv << ['Client Name', 'Employee Name', 'Category', 'Pay', 'Cost', 'Note', 'Assigned Employee', 'Created At']

      # Write data rows
      subscription_records.each do |record|
        csv << [
          record.client.name,
          record.employee.name,
          record.category,
          record.pay,
          record.cost,
          record.note,
          record.assigned_employee,
          record.created_at
        ]
      end
    end

    # Send the CSV file as a response
    send_data csv_data, filename: 'subscription_records.csv', type: 'text/csv; charset=UTF-8'
  end
end
