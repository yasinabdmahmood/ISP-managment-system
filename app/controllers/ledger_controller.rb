class LedgerController < ApplicationController
    def get_ledgers
        # Get the id parameter from the request
        record_id = params[:id]

        if record_id
            # Case 1: Find the record with the given id
            base_record = Ledger.find_by(id: record_id)

            # Check if the Ledger model is empty
            if base_record.nil?
                render json: []
                return
            end

            # Fetch the next 50 records based on the date
            ledgers = Ledger
                            .where('date < ?', base_record.date)
                            .order(date: :desc)
                            .limit(50)
        else
            # Case 3: If id is not provided, return the first 50 records based on date
            ledgers = Ledger
                            .order(date: :desc) # Order by the most recent date
                            .limit(50)
        end

        #render json: next_records.includes(:agent)
        render json: ledgers, include: { 
          agent: { only: [:name, :info] }, 
        }
        # ledgers = Ledger.order(created_at: :desc).includes(:agent)
        # render json: ledgers, include: { 
        #   agent: { only: [:name, :info] }, 
        # }
    end

    def create
        agent_id = params[:agent_id]
        detail = params[:detail] # detail: {type1: 25000, type2: 25000}
        date = params[:date]  # "2023-5-1"
        deposit = params[:deposit]

        withdraw = 0
        detail.each_value do |value|
            withdraw+= value.to_i
        end

        ledger = Ledger.new(
                agent_id: agent_id,
                date: Date.parse(date),
                withdraw: withdraw,
                deposit: 0,
                detail: detail,
                deposit: deposit
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

    def add_to_deposit
        ledger_id = params[:id]
        deposit = params[:deposit]
        ledger = Ledger.find(ledger_id)
        ledger.deposit += deposit.to_i
        if ledger.save
            render json: ledger, include: { 
                agent: { only: [:name, :info] }, 
            }
        else
            render json: {message: 'error'}, status: 400
        end

    end

    def history
        id =params[:id]
        agent = Agent.find(id)
        ledgers = agent.ledgers.order(created_at: :desc).as_json(include: { 
          agent: { only: [:name, :info] },  
        })
    
        render json: ledgers
    
      end
end