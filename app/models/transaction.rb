class Transaction < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :account
  # Validations
  validates :date, presence: true
  validates :name, length: { maximum: 20 }, presence: true
  validates :description, length: { maximum: 50 }
  validates :value, numericality: true
end
