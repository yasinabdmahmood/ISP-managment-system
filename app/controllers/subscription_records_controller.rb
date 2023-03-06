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
      # @new_payment_record = PaymentRecord.new(employee: @current_user, subscription_record: @new_subscription_record,)
     redirect_to subscription_records_path
    else
      redirect_to new_subscription_record_path
    end
  end

  def subscription_record_params
    params.require(:new_subscription_record).permit(:pay, :client_id, :subscription_type_id, :employee_id)
  end
end
