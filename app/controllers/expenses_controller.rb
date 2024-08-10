class ExpensesController < ApplicationController
  def get_expenses
    expenses = Expense.order(created_at: :desc).includes(:account_option, :employee).page(params[:page]).per(20)
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
