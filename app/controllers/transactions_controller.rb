class TransactionsController < ApplicationController
  before_action :set_account, only: [:new, :create]
  before_action :set_transaction_and_account, only: [:edit, :update, :destroy]

  def index
    @transactions = policy_scope(Transaction).order(:date)
    @account = current_user.accounts.find(params[:account_id])
  end

  def new
    @transaction = @account.transactions.new
    authorize @transaction
    @simple_form_models = [@account, @transaction]
  end

  def create
    @transaction = @account.transactions.new(transactions_params)
    if @transaction.save
      redirect_to account_transactions_path(@account)
    else
      render :new
    end
  end

  def edit;
    @simple_form_models = [@transaction]
  end

  def update
    if @transaction.update(transactions_params)
      redirect_to account_transactions_path(@account)
    else
      render :edit
    end
  end

  def destroy
    if @transaction.destroy
      redirect_to account_transactions_path(@account)
    else
      redirect_to account_transactions_path(@account), alert: 'Something went wrong!'
    end
  end

  private

  def transactions_params
    params.require(:transaction).permit(:date, :name, :description, :value, :category_id)
  end

  def set_account
    @account = current_user.accounts.find(params[:account_id])
    authorize @account
  end

  def set_transaction_and_account
    @transaction = Transaction.find(params[:id])
    authorize @transaction
    @account = @transaction.account
    authorize @account
  end
end
