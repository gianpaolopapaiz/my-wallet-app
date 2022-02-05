class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :destroy]

  def index
    @accounts = policy_scope(Account).order(created_at: :desc)
  end

  def new
    @account = current_user.accounts.new
    authorize @account
  end

  def create
    @account = current_user.accounts.new(accounts_params)
    authorize @account
    if @account.save
      redirect_to accounts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @account.update(accounts_params)
      redirect_to accounts_path
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
  end

  private

  def accounts_params
    params.require(:account).permit(:name, :description, :initial_amount)
  end

  def set_account
    @account = current_user.accounts.find(params[:id])
    authorize @account
  end
end
