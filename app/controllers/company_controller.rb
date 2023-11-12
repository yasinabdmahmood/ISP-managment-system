class CompanyController < ApplicationController
  def get_companies
    render json: Company.all
  end

  def create
    name = params[:name]
    
    new_company = Company.new(name: name)
    if new_company.save 
      render json: new_company, status: 200
    else
      render json: { message: "error" }, status: 400
    end
  end

    def destroy
        company_id = params[:id]
        company = Company.find(company_id)
        if company.destroy
        render json: {company_id: company_id}, status: 200
        else
        render json: {message: 'error'}, status: 400
        end  
    end


    def update
    name = params["name"]
    id = params["id"]

    company = Company.find(id);
    if company
        company.name = name
        
        if company.save
        render json: company
        else
        render json: {message: 'invalid update'}, status: 400
        end
    else
        render json: {message: 'No such company exist'}, status: 400
    end
    

    end
end

