class Agent < ApplicationRecord
    has_many :ledgers

    validates :name, presence: true, uniqueness: true
    validates :info, presence: true
end
