class RemoveDateTimeFromTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :date_time, :datetime
  end
end
