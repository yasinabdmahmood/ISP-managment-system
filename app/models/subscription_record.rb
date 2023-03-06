class SubscriptionRecord < ApplicationRecord
    after_create :create_payment_record


    belongs_to :client
    belongs_to :subscription_type
    belongs_to :employee
    has_many :payment_records, :dependent => :destroy

    validates_associated :payment_records
    validates :pay, presence: true 

    private

    def create_payment_record
        PaymentRecord.create(employee: self.employee,subscription_record: self,amount: self.pay)
    end
    
end  