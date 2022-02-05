class AddInitialAmountToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :initial_amount, :float, default: 0
  end
end
