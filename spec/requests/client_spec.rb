require 'rails_helper'

RSpec.describe "Clients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/client/index"
      expect(response).to have_http_status(:success)
    end
  end

end
