class ClientContactInformationController < ApplicationController
    skip_before_action :verify_authenticity_token
    def new
      @new_employee_contact_information = EmployeeContactInformation.new
    end
  
    def create
      @new_client_contact_information = ClientContactInformation.new(client_contact_information_params)
      # Removing any white spaces from the phone number to ensure it contains only digits.
      @new_client_contact_information.contact_info = remove_whitespace(@new_client_contact_information.contact_info)
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

    def remove_whitespace(input_string)
      # Use gsub to replace all white spaces (including spaces, tabs, and line breaks) with an empty string.
      input_string.gsub(/\s+/, "")
    end
  
  end
  