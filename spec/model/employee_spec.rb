require 'rails_helper'

RSpec.describe Employee, type: :model do
    subject(:employee) { described_class.new(name: 'John Doe', role: 'employee') }
  
    it { is_expected.to have_many(:employee_contact_information) }
    it { is_expected.to have_many(:subscription_records) }
    it { is_expected.to have_many(:payment_records) }
  
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(30) }
    it { is_expected.to validate_uniqueness_of(:name) }
  
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_inclusion_of(:role).in_array(%w[admin employee]) }
  
    it { is_expected.to validate_associated(:employee_contact_information) }
    it { is_expected.to validate_associated(:subscription_records) }
    it { is_expected.to validate_associated(:payment_records) }
  end
  