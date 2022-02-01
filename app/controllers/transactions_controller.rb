class TransactionsController < ApplicationController
  def index
    @transactions = policy_scope(Transaction).order(date: :desc)
    @account = current_user.accounts.find(params[:account_id])
  end
end
