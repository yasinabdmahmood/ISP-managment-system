require 'rails_helper'

RSpec.describe "EmployeeContactInformation", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/employee_contact_information/new"
      expect(response).to have_http_status(:success)
    end
  end

end
