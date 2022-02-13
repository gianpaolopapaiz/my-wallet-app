class AddSubcategoryToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :subcategory, null: true, foreign_key: true
  end
end
