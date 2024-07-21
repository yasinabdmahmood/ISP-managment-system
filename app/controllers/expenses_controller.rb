class ExpensesController < ApplicationController
  def get_expenses
    expenses = Expense.order(created_at: :desc).includes(:account_option).page(params[:page]).per(20)
    # expenses = Expense.all.includes(:account_option)
    render json: expenses, include: { account_option: { only: [:id, :options] } }
  end
end
