class ChangeCheckNumberTypeOnTransaction < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :check_number, :string
  end
end
