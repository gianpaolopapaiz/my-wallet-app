class Transaction < ApplicationRecord
  # Associations
  belongs_to :category, optional: true
  belongs_to :account
  # Validations
  validates :date, presence: true
  validates :name, length: { maximum: 30 }, presence: true
  validates :description, length: { maximum: 50 }
  validates :value, numericality: true

  def account_balance
    account.initial_amount + self.account.transactions.where("date <= :date", date: self.date).sum(:value)
  end

  def value_class
    value >= 0 ? 'positive-number' : 'negative-number'
  end

  def account_balance_class
    account_balance >= 0 ? 'positive-number' : 'negative-number'
  end
end
