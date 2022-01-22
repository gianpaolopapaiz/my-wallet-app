class Transaction < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :account
  # Validations
  validates :name, :date, :value, presence: true
end
