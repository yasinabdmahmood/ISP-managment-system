class SubscriptionTypeController < ApplicationController
  def index
    @subscription_types = SubscriptionType.all
  end

  def new
    @new_subscription_type = SubscriptionType.new
  end

  def destroy
    @subscription_type = SubscriptionType.find(params[:id])
    @subscription_type.destroy

    redirect_to subscription_type_index_path, notice: "User was successfully deleted."
  end

  
  def create
    @new_subscription_type = SubscriptionType.new(subscription_type_params)
    if @new_subscription_type.save
      redirect_to subscription_type_index_path
    else
      redirect_to :new
    end
  end

  private

  def subscription_type_params
    params.require(:new_subscription_type).permit(:category, :cost, :profit)
  end
end
