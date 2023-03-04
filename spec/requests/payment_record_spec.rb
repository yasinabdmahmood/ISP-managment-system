require 'rails_helper'

RSpec.describe "PaymentRecords", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/payment_record/index"
      expect(response).to have_http_status(:success)
    end
  end

end
