class TestController < ApplicationController
    def test 
        render json: {data: "Test action responded successfully"}
    end
end
