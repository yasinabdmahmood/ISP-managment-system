class SubscriptionTypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @subscription_types = SubscriptionType.all
    render json: @subscription_types
  end

  def new
    @new_subscription_type = SubscriptionType.new
  end

  def destroy
    @subscription_type = SubscriptionType.find(params[:id])
    if @subscription_type.destroy
      render json: {subscription_type_id: params[:id]}, status: 200
    else
      render json: {message: 'error'}, status: 400
    end  
  end

  
  def create
      @new_subscription_type = SubscriptionType.new(subscription_type_params)
      if @new_subscription_type.save
        render json: { message: "success", subscription_type: @new_subscription_type }, status: 200
      else
        render json: { message: "error" }, status: 400
      end
  end

  def edit
    @subscription_type = SubscriptionType.find(params[:id])
  end

  def update
    @subscription_type = SubscriptionType.find(params[:id])

    if @subscription_type.update(subscription_type_params)
      # Successful update, do something (e.g., redirect to the record's page)
      render json: { message: "success", subscription_type: @subscription_type }, status: 200
    else
      # Failed update, render the edit form again with error messages
      render json: { message: "error" }, status: 400
    end
  end

  private

  def subscription_type_params
    params.require(:new_subscription_type).permit(:category, :cost, :profit)
  end
end
