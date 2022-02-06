class AddCheckNumberToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :check_number, :integer
  end
end
