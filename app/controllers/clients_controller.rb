class ClientsController < ApplicationController
  def index
    @clients = Client.all.includes(:client_contact_informations)
  end
  
  def new
  end
end
