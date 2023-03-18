class ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @clients = Client.all.includes(:client_contact_informations)
    render json: @clients, include: { client_contact_informations: { only: [:contact_info] } }
  end
  
  def new
    @new_client = Client.new
  end

  def create
    name = params[:new_client][:name]
    username = params[:new_client][:username]
    contact_info = params[:new_client][:contact_info]
    @new_client = Client.new(name: name, username: username)
    @contact_info = ClientContactInformation.create(client: @new_client, contact_info: contact_info)
    if @new_client.save 
      render json: @new_client.as_json(include: { client_contact_informations: { only: [:contact_info] } })
    else
      render json: { message: "error" }
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    redirect_to clients_path, notice: "Client was successfully deleted."
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update

    # @client = Client.find(params[:id])
    # if @client.update(updated_client_params)
    #   redirect_to clients_path
    # else
    #   redirect_to edit_client_path(@client)
    # end
    name = params[:updated_client][:name]
    username = params[:updated_client][:username]
  
    # Access nested attribute values using the association name
    contact_info = params[:updated_client][:client_contact_informations_attributes][:'0'][:contact_info]
    @client = Client.find(params[:id])
    p name
    p username
    p contact_info

    if @client.update(name: name, username: username)
       @client.client_contact_informations.first.update(contact_info: contact_info)
      # Successful update, do something (e.g., redirect to the record's page)
      redirect_to clients_path
    else
      # Failed update, render the edit form again with error messages
      redirect_to edit_client_path(@subscription_type)
    end
  end

  private

  def client_params
    params.require(:new_client).permit(:name, :username, :contact_info)
  end

  def updated_client_params
    params.require(:updated_client).permit(:name, :username, client_contact_information: [:id, :contact_info])
  end

  # def updated_client_params
  #   params.require(:updated_client).permit(:name, :username, :contact_info)
  # end
end
