class ClientContactInformationController < ApplicationController
    skip_before_action :verify_authenticity_token
    def new
      @new_employee_contact_information = EmployeeContactInformation.new
    end
  
    def create
      @new_client_contact_information = ClientContactInformation.new(client_contact_information_params)
      if @new_client_contact_information.save
        render json: { message: 'Success' }, status: 200
      else
        render json: { error: 'An error occurred' }, status: 400
      end
    end
  
    def destroy
      contact_info = ClientContactInformation.find(params[:id])
      if contact_info.destroy
        render json: { message: 'Success' }, status: 200
      else
        render json: { error: 'An error occurred' }, status: 400
      end
    end
  
    private
  
    def client_contact_information_params
      params.require(:new_client_contact_information).permit(:contact_info, :client_id)
    end
  
  end
  