class StatisticsController < ApplicationController
  def index
    @transactions = policy_scope(Transaction)
    # Filters
    # Account
    @account_id = nil
    if !params[:account].blank? && params[:account].to_i >= 0
      @transactions = @transactions.where('account_id = :account_id', account_id: params[:account])
      @account_id = params[:account]
    end
    # Date
    @start_date = Date.today.at_beginning_of_year
    @end_date = Date.today.at_end_of_month
    @end_of_year = Date.today.at_end_of_year
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
    @transactions_total = @transactions.sum(:value)
    @transactions_by_category = @transactions.joins(:category).
                                               group('categories.name').
                                               order('categories.name').
                                               sum('transactions.value')
    @transactions_by_week = @transactions.group_by_week(:date).sum(:value)
    @transactions_by_month = @transactions.group_by_month(:date,  format: "%b").sum(:value)
  end
end