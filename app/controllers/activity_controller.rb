class ActivityController  < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # if the current user is not admin then they can not elevate an employee to become admin
    if current_employee.role != 'admin'
      render json: {message: 'You are not authorized to perform this action'}, status: 401
      return
    end

    
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
