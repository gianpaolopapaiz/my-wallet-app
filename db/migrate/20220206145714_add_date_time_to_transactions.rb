class AddDateTimeToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :date_time, :datetime
  end
end
