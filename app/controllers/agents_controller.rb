class AgentsController < ApplicationController
    def get_agents
        render json: Agent.all
    end
  end
  