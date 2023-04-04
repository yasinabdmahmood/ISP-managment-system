class PaymentRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if PaymentRecord.count == 0
      render json: []
      return
    end
    fetched_items_at_once = 20
    n = params[:offset].to_i 
    
    total_records = PaymentRecord.count
    
    offset = fetched_items_at_once*n

    if offset > total_records-fetched_items_at_once
      render json: []
      return
    end
    @payment_records = PaymentRecord.order(created_at: :desc).includes(:subscription_record => [:client], :employee => []).offset(offset).limit(fetched_items_at_once)
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
      render json: @new_payment_record, include: { 
      employee: { only: [:name] }, 
      subscription_record: {
        include: {
          client: { },
        }
      }
    }, status: 200
    else
      render json: { error: 'payment can not be greater than the cost' }, status: 400
    end
  end

  def destroy
    id = params[:id]
    payment_record = PaymentRecord.find(id)
    amount = payment_record.amount
    subscription_record = payment_record.subscription_record
    old_pay = subscription_record.pay
    subscription_record.update(pay: old_pay - amount )

    parsed_subscription_record = subscription_record.as_json(include: { 
      client: { only: [:name] }, 
      employee: { only: [:name] }, 
      subscription_type: { only: [:category, :cost] } 
    })
    if payment_record.destroy
      render json: {mesage: 'success', updated_subscription_record: parsed_subscription_record, payment_id: id}, status: 200
    else
      render json: {message: 'error'}, status: 400
    end

    

  end

  private

  def payment_record_params
    params.require(:new_payment_record).permit(:amount, :subscription_record_id)
  end

end
