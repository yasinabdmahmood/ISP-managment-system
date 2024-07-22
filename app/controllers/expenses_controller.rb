class ExpensesController < ApplicationController
  def get_expenses
    expenses = Expense.order(created_at: :desc).includes(:account_option, :employee).page(params[:page]).per(20)
    render json: expenses, include: { 
      account_option: { only: [:id, :options] },
      employee: { only: [:name] },  
    }
  end

  def get_account_options
    render json: AccountOption.all
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
        render json: {message: 'error'}, status: 400
    end
end
end
