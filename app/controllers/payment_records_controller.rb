class PaymentRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @payment_records = PaymentRecord.all.includes(:subscription_record => [:client], :employee => [])
    render json: @payment_records, include: { 
      employee: { only: [:name] }, 
      subscription_record: {
        include: {
          client: { },
        }
      }
    }
  end
  

  def new
    @new_payment_record = PaymentRecord.new
  end

  def create
    @new_payment_record =PaymentRecord.new(payment_record_params)
    @new_payment_record.employee = current_employee
    subscription_fee =@new_payment_record.subscription_record.subscription_type.cost
    current_subscription_record_pay = @new_payment_record.subscription_record.pay

    if @new_payment_record.amount + current_subscription_record_pay <= subscription_fee 
      @new_payment_record.save
      @new_payment_record.subscription_record.update(pay: @new_payment_record.subscription_record.pay += @new_payment_record.amount)
      render json: {message: 'sucsess'}
    else
      render json: {message: 'error'}
    end
  end

  private

  def payment_record_params
    params.require(:new_payment_record).permit(:amount, :subscription_record_id)
  end

end
