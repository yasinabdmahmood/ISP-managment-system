class SubscriptionRecordController < ApplicationController
  def index
    @subscription_records = SubscriptionRecord.all.includes(:client, :subscription_type, :employee)
  end
end
