class SubscriptionRecordsController < ApplicationController
  def index
    @subscription_records = SubscriptionRecord.all.includes(:client, :subscription_type, :employee)
  end

  def new
    @new_subscription_record = SubscriptionRecord.new
    @subscription_types = SubscriptionType.all
    @clients = Client.all 
  end

  def create
    @new_subscription_record = SubscriptionRecord.new(subscription_record_params)
    if @new_subscription_record.save
     @new_payment_record = PaymentRecord.create(employee: current_employee, subscription_record: @new_subscription_record,amount: @new_subscription_record.pay)
     redirect_to subscription_records_path
    else
      redirect_to new_subscription_record_path
    end
  end

  def destroy
    @subscription_record = SubscriptionRecord.find(params[:id])
    if @subscription_record.destroy
      redirect_to subscription_records_path
    end
  end

  def edit
    @subscription_record = SubscriptionRecord.find(params[:id])
    p @subscription_record
    @subscription_types = SubscriptionType.all
    @clients = Client.all 
  end

  def update
  end


  private

  def subscription_record_params
    params.require(:new_subscription_record).permit(:pay, :client_id, :subscription_type_id, :employee_id)
  end
end
