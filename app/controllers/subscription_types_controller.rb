class SubscriptionTypesController < ApplicationController
  def index
    @subscription_types = SubscriptionType.all
  end

  def new
    @new_subscription_type = SubscriptionType.new
  end

  def destroy
    @subscription_type = SubscriptionType.find(params[:id])
    @subscription_type.destroy

    redirect_to subscription_types_path, notice: "User was successfully deleted."
  end

  
  def create
    @new_subscription_type = SubscriptionType.new(subscription_type_params)
    if @new_subscription_type.save
      redirect_to subscription_types_path
    else
      redirect_to :new
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
