class ExpensesController < ApplicationController
  def get_expenses
    expenses = Expense.all.includes(:account_option)
    render json: expenses, include: { account_option: { only: [:id, :options] } }
  end
end
