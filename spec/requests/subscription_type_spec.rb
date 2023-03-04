require 'rails_helper'

RSpec.describe "SubscriptionTypes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/subscription_type/index"
      expect(response).to have_http_status(:success)
    end
  end

end
