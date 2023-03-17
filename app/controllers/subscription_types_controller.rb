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
    @subscription_type.destroy

    render json: {subscription_type_id: params[:id]}
  end

  
  def create
    def create
      @new_subscription_type = SubscriptionType.new(subscription_type_params)
      if @new_subscription_type.save
        render json: { message: "success", subscription_type: @new_subscription_type }
      else
        render json: { message: "error" }
      end
    end
  end

  def edit
    @subscription_type = SubscriptionType.find(params[:id])
  end

  def update
    @subscription_type = SubscriptionType.find(params[:id])

    if @subscription_type.update(subscription_type_params)
      # Successful update, do something (e.g., redirect to the record's page)
      redirect_to subscription_types_path
    else
      # Failed update, render the edit form again with error messages
      redirect_to edit_subscription_type_path(@subscription_type)
    end
  end

  private

  def subscription_type_params
    params.require(:new_subscription_type).permit(:category, :cost, :profit)
  end
end
