class ClientContactInformation < ApplicationRecord
  belongs_to :client

  validates :contact_info, presence: true, length: { minimum: 7, maximum: 50 }
end
