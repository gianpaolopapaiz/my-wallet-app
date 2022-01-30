class Account < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :transactions, dependent: :destroy
  # Validations
  validates :name, length: { maximum: 20 }, presence: true
  validates :description, length: { maximum: 50 }
end
