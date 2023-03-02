require 'rails_helper'

RSpec.describe ClientContactInformation, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      client = Client.create(name: "John Smith", username: "jsmith")
      contact_info = "1234567"
      client_contact_info = ClientContactInformation.new(client_id: client.id, contact_info: contact_info)
      expect(client_contact_info).to be_valid
    end

    it "is not valid without a client" do
      contact_info = "1234567"
      client_contact_info = ClientContactInformation.new(contact_info: contact_info)
      expect(client_contact_info).to_not be_valid
    end

    it "is not valid without contact info" do
      client = Client.create(name: "John Smith", username: "jsmith")
      client_contact_info = ClientContactInformation.new(client_id: client.id)
      expect(client_contact_info).to_not be_valid
    end

    it "is not valid with contact info shorter than 7 characters" do
      client = Client.create(name: "John Smith", username: "jsmith")
      contact_info = "123456"
      client_contact_info = ClientContactInformation.new(client_id: client.id, contact_info: contact_info)
      expect(client_contact_info).to_not be_valid
    end

    it "is not valid with contact info longer than 50 characters" do
      client = Client.create(name: "John Smith", username: "jsmith")
      contact_info = "123456789012345678901234567890123456789012345678901"
      client_contact_info = ClientContactInformation.new(client_id: client.id, contact_info: contact_info)
      expect(client_contact_info).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a client" do
      client_contact_info = ClientContactInformation.new(contact_info: "1234567")
      expect(client_contact_info).to respond_to(:client)
    end
  end
end

  