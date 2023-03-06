class ApplicationController < ActionController::Base

    before_action :set_user

    private
  
    def set_user
      @current_user_id = Employee.first.id
    end
end
