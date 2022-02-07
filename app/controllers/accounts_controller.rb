class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy, :ofx_import, :ofx_import_to_account]

  def index
    @accounts = policy_scope(Account).order(created_at: :desc)
  end

  def show
    @transactions = @account.transactions.order(:date)
    # Filters
    # Date
    @start_date = Date.today.at_beginning_of_year
    @end_date = Date.today.at_end_of_month
    if !params[:start_date].blank? && !params[:end_date].blank?
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end
    @transactions = @transactions.where('date >= :start_date AND date <= :end_date',
                                        start_date: @start_date, end_date: @end_date)
    # Payment Type
    @payment_type = 'All'
    if params[:payment_type] == 'Income'
      @transactions = @transactions.where('value >= 0')
      @payment_type = 'Income'
    end
    if params[:payment_type] == 'Expense'
      @transactions = @transactions.where('value < 0')
      @payment_type = 'Expense'
    end
    # Category
    @category_id = nil
    if !params[:category].blank? && params[:category].to_i >= 0
      @transactions = @transactions.where('category_id = :category_id', category_id: params[:category])
      @category_id = params[:category]
    end
    @transactions_count = @transactions.count
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

  def ofx_import; end

  def ofx_import_to_account
    wallet_account = @account
    ofx_file = params[:account][:ofx_file]
    OFX(ofx_file) do
      account.transactions.each do |ofx_transaction|
        wallet_transaction = wallet_account.transactions.new(name: ofx_transaction.memo,
                                                             check_number: ofx_transaction.check_number,
                                                             date: ofx_transaction.posted_at,
                                                             value: ofx_transaction.amount)
        wallet_transaction.save!
      end
    end
    redirect_to account_path(@account)
  end

  private

  def accounts_params
    params.require(:account).permit(:name, :description, :initial_amount)
  end

  def set_account
    id = params[:id] || params[:account_id]
    @account = current_user.accounts.find(id)
    authorize @account
  end
end
