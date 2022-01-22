class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.text :description
      t.date :date
      t.float :value
      t.references :category, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
