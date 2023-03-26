class ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @clients = Client.order(created_at: :desc).includes(:client_contact_informations)
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
    if @new_client.save 
      @contact_info = ClientContactInformation.create(client: @new_client, contact_info: contact_info)
      # render json: @new_client.as_json(include: { client_contact_informations: { only: [:contact_info] } })
      render json: { client: @new_client, contact_info: contact_info}
    else
      render json: { message: "error" }
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    render json: {client_id: params[:id]}
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
    contact_info = params[:updated_client][:contact_info]
    @client = Client.find(params[:id])

    if @client.update(name: name, username: username)
       @client.client_contact_informations.first.update(contact_info: contact_info)
      # Successful update, do something (e.g., redirect to the record's page)
      render json: {message: 'success', client: @client, contact_info: contact_info}
    else
      # Failed update, render the edit form again with error messages
      render json: {message: 'error'}
    end
  end

  def history
    id =params[:id]
    client = Client.find(id)
    subscription_records = client.subscription_records.as_json(include: { 
      client: { only: [:name] }, 
      employee: { only: [:name] }, 
      subscription_type: { only: [:category, :cost] } 
    })

    render json: subscription_records

  end

  private

  def client_params
    params.require(:new_client).permit(:name, :username, :contact_info)
  end

  def updated_client_params
    params.require(:updated_client).permit(:name, :username, :contact_info)
  end

  # def updated_client_params
  #   params.require(:updated_client).permit(:name, :username, :contact_info)
  # end
end
