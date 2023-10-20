class AgentsController < ApplicationController
    def get_agents
        render json: Agent.all
    end

    def create
        name = params[:new_agent][:name]
        info = params[:new_agent][:info]
        
        new_agent = Agent.new(name: name, info: info)
        if new_agent.save 
          render json: new_agent, status: 200
        else
          render json: { message: "error" }, status: 400
        end
      end

    def destroy
        agent_id = params[:id]
        agent = Agent.find(agent_id)
        if agent.destroy
          render json: {agent_id: agent_id}, status: 200
        else
          render json: {message: 'error'}, status: 400
        end  
    end

  end
  