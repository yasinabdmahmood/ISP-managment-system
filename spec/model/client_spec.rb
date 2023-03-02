require 'rails_helper'
RSpec.describe Client, type: :model do
    subject { described_class.new(name: "Test Client", username: "testclient") }
  
    describe "validations" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
  
      it "is not valid without a name" do
        subject.name = nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid with a name that is too short" do
        subject.name = "a"
        expect(subject).to_not be_valid
      end
  
      it "is not valid with a name that is too long" do
        subject.name = "a" * 31
        expect(subject).to_not be_valid
      end
  
      it "is not valid with a duplicate name" do
        newClient = described_class.create(name: "Test Client")
        expect(newClient).to_not be_valid
      end
  
      it "is not valid without a username" do
        subject.username = nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid with a username that is too short" do
        subject.username = "a"
        expect(subject).to_not be_valid
      end
  
      it "is not valid with a username that is too long" do
        subject.username = "a" * 31
        expect(subject).to_not be_valid
      end
  
      it "is not valid with a duplicate username" do
        newClient = described_class.create(username: "testclient")
        expect(newClient).to_not be_valid
      end
  
      it "is valid with associated client_contact_information" do
        subject.client_contact_informations.build(contact_info: "test@example.com")
        expect(subject).to be_valid
      end
  
      it "is valid with associated subscription_records" do
        employee_test = Employee.create(name: "employee1", role: "admin")
        subscription_type_test = SubscriptionType.create(category: 'Economic',cost: 38000, profit: 5000)
        SubscriptionRecord.create(client: subject, employee: employee_test, subscription_type: subscription_type_test)
        expect(subject).to be_valid
      end
  
      it "is not valid with invalid associated client_contact_informations" do
        subject.client_contact_informations.build(contact_info: nil)
        expect(subject).to_not be_valid
      end
  
      it "is not valid with invalid associated subscription_records" do
        subject.subscription_records.build()
        expect(subject).to_not be_valid
      end
    end
end
  