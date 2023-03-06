class ApplicationController < ActionController::Base

    before_action :set_user

    private
  
    def set_user
      @current_user = Employee.first
    end
end
