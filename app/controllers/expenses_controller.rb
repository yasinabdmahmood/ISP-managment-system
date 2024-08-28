class ExpensesController < ApplicationController
  def get_expenses
    expenses = Expense.order(created_at: :desc).includes(:account_option, :employee).page(params[:page]).per(20)
    render json: expenses, include: { 
      account_option: { only: [:id, :options] },
      employee: { only: [:name] },  
    }
  end

  def get_searched_expenses
    start_day = params[:start_day].to_i
    start_month = params[:start_month].to_i
    start_year = params[:start_year].to_i
    end_day = params[:end_day].to_i
    end_month = params[:end_month].to_i
    end_year = params[:end_year].to_i
    start_date = Date.new(start_year, start_month, start_day) 
    end_date = Date.new(end_year, end_month, end_day)       
  
    # Convert the dates to the beginning of the start_date and end of the end_date
    start_datetime = start_date.beginning_of_day
    end_datetime = end_date.end_of_day
  
    # Query the expenses between the start_datetime and end_datetime
    expenses = Expense.where(created_at: start_datetime..end_datetime)
                      .includes(:account_option, :employee)
                      
    render json: expenses, include: { 
      account_option: { only: [:id, :options] },
      employee: { only: [:name] },  
    }
  end

  def get_pending_expenses
    expenses = Expense.where(status: 'pending')
                      .order(created_at: :desc)
                      .includes(:account_option, :employee)
                      .page(params[:page])
                      .per(20)
    render json: expenses, include: { 
      account_option: { only: [:id, :options] },
      employee: { only: [:name] },  
    }
  end
  

  def get_account_options
    render json: AccountOption.all
  end

  def create_account_options
    options = params[:options]
    account_option = AccountOption.new(options: options)
    if account_option.save
        render json: account_option, status: 200
    else
        render json: {message: 'error'}, status: 400
    end
  end

  def create_expense
    employee = @current_employee
    amount = params[:amount]
    remark = params[:remark]
    date = params[:date]
    account_option_id = params[:account_option_id]
    account_option = AccountOption.find(account_option_id)


    expense = Expense.new(
            date: Date.parse(date),
            amount: amount,
            remark: remark,
            account_option: account_option,
            status: 'pending',
            employee: employee
        )  
    if expense.save
        render json: expense, include: { 
          account_option: { only: [:id, :options],
          employee: { only: [:name] }, 
         } 
    }, status: 200
    else
        p '000000000000000'
        expense.errors.full_messages.each do |message|
          puts "- #{message}"
        end
        p '00000000000000'
        render json: {message: 'error'}, status: 400
    end
  end

  def update_expense_status
    #param = {id,newStatus}
    id = params[:id]
    newStatus = params[:newStatus]
    expense = Expense.find(id)
    expense.status = newStatus;
    if expense.save
        render json: expense, include: { 
          account_option: { only: [:id, :options],
          employee: { only: [:name] }, 
         } 
    }, status: 200
    else 
        p '000000000000000'
        expense.errors.full_messages.each do |message|
          puts "- #{message}"
        end
        p '00000000000000'
        render json: {message: 'error'}, status: 400
    end

  end
  
end
