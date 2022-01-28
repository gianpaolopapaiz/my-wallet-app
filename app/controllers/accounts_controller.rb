class AccountsController < ApplicationController
  def index
    @accounts = policy_scope(Account).order(created_at: :desc)
  end

  def new
    @account = Account.new
    authorize @account
  end
end
