class SubscriptionRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if SubscriptionRecord.count == 0
      render json: []
      return
    end
    fetched_items_at_once = 20
    n = params[:offset].to_i 
    
    total_records = SubscriptionRecord.count
    
    offset = fetched_items_at_once*n
    @subscription_records = SubscriptionRecord.order(created_at: :desc).includes(:client, :subscription_type, :employee).offset(offset).limit(fetched_items_at_once)
    render json: @subscription_records, include: { 
      client: { only: [:name] }, 
      employee: { only: [:name] }, 
      subscription_type: { only: [:category, :cost] } 
    }

    # uncomment below if you want to fetch all the records
    # render json: SubscriptionRecord.all, include: { 
    #   client: { only: [:name] }, 
    #   employee: { only: [:name] }, 
    #   subscription_type: { only: [:category, :cost] } 
    # }
  end

  def filter
    start_date = params.dig(:date, :start)
    end_date = params.dig(:date, :end)
    filter = params.dig(:filter)
  
    subscription_records = SubscriptionRecord.order(created_at: :desc).includes(:client, :subscription_type, :employee)
  
    if start_date.present? && end_date.present?
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      subscription_records = subscription_records.where(created_at: start_date..end_date + 1.day)
    end
  
    if filter.present?
      if filter == 'unpaid'
        subscription_records = subscription_records.where("pay != cost")
      end
    end
  
    total_records = subscription_records.count
  
    render json: subscription_records, include: { 
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
    @new_subscription_record.cost = @new_subscription_record.subscription_type.cost
    @new_subscription_record.category = @new_subscription_record.subscription_type.category
    if @new_subscription_record.save
      @new_payment_record = PaymentRecord.new(employee: current_employee, subscription_record: @new_subscription_record,amount: @new_subscription_record.pay)
      if @new_payment_record.save
        @client = @new_subscription_record.client
        @employee = @new_subscription_record.employee
        @subscription_type = @new_subscription_record.subscription_type
        
        subscription_record = @new_subscription_record.as_json(include: { 
          client: { only: [:name] }, 
          employee: { only: [:name] }, 
          subscription_type: { only: [:category, :cost] } 
        })
        
        payment_record = @new_payment_record.as_json(include: { 
          employee: { only: [:name] }, 
          subscription_record: {
            include: {
              client: { },
            }
          }
        })
        
        render json: {
          message: 'success',
          subscriptionRecord: subscription_record,
          paymentRecord: payment_record
        }, status: 200
      else
        render json: { message: @new_payment_record.errors.full_messages }, status: 400
      end
    else
      render json: { message: 'error' }, status: 400
    end
  end
  

  def destroy
    @subscription_record = SubscriptionRecord.find(params[:id])
    if @subscription_record.destroy
      render json: {message: 'success', id: params[:id]}, status: 200
    else
      rendef json: { mesage: 'error'}, status: 400
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

  def history
    id =params[:id]
    subscription_record = SubscriptionRecord.find(id)
    payment_records = subscription_record.payment_records.order(created_at: :desc).as_json(include: { 
      employee: { only: [:name] }, 
      subscription_record: {
        include: {
          client: { },
        }
      }
    })

    render json: payment_records

  end


  private

  def subscription_record_params
    params.require(:new_subscription_record).permit(:pay, :client_id, :subscription_type_id, :employee_id, :created_at, :note)
  end
end
