class BackupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    total_records = Activity.count

    if total_records == 0
      render json: []
      return
    end

    fetched_items_at_once = 100
    n = params[:offset].to_i 
    
    
    
    offset = fetched_items_at_once*n

    @activities = Activity.order(created_at: :desc).offset(offset).limit(fetched_items_at_once)
    render json: @activities
  end
end
