class SubscriptionRecordsController < ApplicationController
  def index
    @subscription_records = SubscriptionRecord.all.includes(:client, :subscription_type, :employee)
  end

  def new
    @new_subscription_record = SubscriptionRecord.new
    @subscription_types = SubscriptionType.all
    @clients = Client.all 
  end

  # def subscription_record_params
  #   params.require(:product).permit(:pay, :client_id, :subscription_type_id)
  # end
end
