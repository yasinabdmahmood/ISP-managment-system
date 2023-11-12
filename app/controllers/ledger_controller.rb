class LedgerController < ApplicationController
    def get_ledgers
        ledgers = Ledger.order(created_at: :desc).includes(:agent)
        render json: ledgers, include: { 
          agent: { only: [:name] }, 
        }
    end

    def create
        agent_id = params[:agent_id]
        detail = params[:detail] # detail: {type1: 25000, type2: 25000}
        date = params[:date]  # "2023-5-1"

        withdraw = 0
        detail.each_value do |value|
            withdraw+= value.to_i
        end

        ledger = Ledger.new(
                agent_id: agent_id,
                date: Date.parse(date),
                withdraw: withdraw,
                deposit: 0,
                detail: detail
            )  
        if ledger.save
            render json: ledger, include: { 
          agent: { only: [:name] }, 
        }, status: 200
        else
            render json: {message: 'error'}, status: 400
        end
    end

    def destroy
        ledger_id = params[:id]
        ledger = Ledger.find(ledger_id)
        if ledger.destroy
            render json: {ledger_id: ledger_id}, status: 200
        else
            render json: {message: 'error'}, status: 400
        end
    end


    # ledger = Ledger.new(
    #         agent: agent,
    #         date: Date.parse("2023-5-1"),
    #         withdraw: 50000,
    #         deposit: 0,
    #         detail: {type1: 25000, type2: 25000}
    #     )
end