class EmployeeContactInformation < ApplicationRecord
    belongs_to :employee

    validates :contact_info, presence: true, length: { minimum: 7, maximum: 50 }
end
