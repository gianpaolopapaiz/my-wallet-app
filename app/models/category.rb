class Category < ApplicationRecord
  # Associations
  belongs_to :user
  # Validations
  validates :name, length: { maximum: 20 }, presence: true
  validates :description, length: { maximum: 50 }
end
