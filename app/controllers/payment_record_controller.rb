class PaymentRecordController < ApplicationController
  def index
    @payment_records = PaymentRecord.all
  end
end
