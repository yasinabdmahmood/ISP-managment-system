class PaymentRecordsController < ApplicationController
  def index
    @payment_records = PaymentRecord.all
  end

  def new
    @new_payment_record = PaymentRecord.new
  end

  def create
    @new_payment_record =PaymentRecord.new(payment_record_params)
    @new_payment_record.employee = @current_user
    if @new_payment_record.save
      @new_payment_record.subscription_record.update(pay: @new_payment_record.subscription_record.pay += @new_payment_record.amount)
      redirect_to subscription_records_path
    else
      redirect_to create_payment_record_path(payment_record_params[:subscription_record_id])
    end
  end

  private

  def payment_record_params
    params.require(:new_payment_record).permit(:amount, :subscription_record_id)
  end

end
