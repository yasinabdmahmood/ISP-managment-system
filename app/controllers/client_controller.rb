class ClientController < ApplicationController
  def index
    @clients = Client.all.includes(:client_contact_informations)
  end
end
