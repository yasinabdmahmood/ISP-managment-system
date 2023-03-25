class SubscriptionRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    fetched_items_at_once = 20
    n = params[:offset].to_i 
    
    total_records = SubscriptionRecord.count
    
    offset = fetched_items_at_once*n

    if offset > total_records-fetched_items_at_once
      render json: []
    end
    @subscription_records = SubscriptionRecord.order(created_at: :desc).includes(:client, :subscription_type, :employee).offset(offset).limit(fetched_items_at_once)
    render json: @subscription_records, include: { 
      client: { only: [:name] }, 
      employee: { only: [:name] }, 
      subscription_type: { only: [:category, :cost] } 
    }
  end
  

  def new
    @new_subscription_record = SubscriptionRecord.new
    @subscription_types = SubscriptionType.all
    @clients = Client.all 
  end

  def create
    @new_subscription_record = SubscriptionRecord.new(subscription_record_params)
    if @new_subscription_record.save
     @new_payment_record = PaymentRecord.new(employee: current_employee, subscription_record: @new_subscription_record,amount: @new_subscription_record.pay)
     if @new_payment_record.save
      @client = @new_subscription_record.client
      @employee = @new_subscription_record.employee
      @subscription_type = @new_subscription_record.subscription_type
      render json: { message: 'success', subscriptionRecord: @new_subscription_record, client: @client, employee: @employee, subscriptionType: @subscription_type }
     else
      render json: { message: 'error' }
     end
     
    else
      redirect_to new_subscription_record_path
    end
  end

  def destroy
    @subscription_record = SubscriptionRecord.find(params[:id])
    if @subscription_record.destroy
      render json: {message: 'success', id: params[:id]}
    else
      rendef json: { mesage: 'error'}
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
