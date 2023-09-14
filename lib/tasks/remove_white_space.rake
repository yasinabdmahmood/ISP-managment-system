task :remove_white_space => :environment do
    # Your code to modify the records here
    client_contact_information_records = ClientContactInformation.all

    client_contact_information_records.each do |record|
        old_contact_info = record.contact_info
        new_contact_info = old_contact_info.gsub(/\s+/, "")
        record.contact_info = new_contact_info
        record.save
    end

    puts "Task completed!"
end
  