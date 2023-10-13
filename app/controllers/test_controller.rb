class TestController < ApplicationController
    def test 
        requested_data = params[:requested_data]

        case requested_data 
        when "company"    
            render json: Company.all
        when "ledger"    
            render json: Ledger.all
        when "agent"    
            render json: Agent.all
        else
          render json: {data: "You did not ask for any data"}
        end
    end
end
