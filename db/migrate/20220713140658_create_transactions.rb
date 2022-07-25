# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :amount, null: false

      t.timestamps
    end
    add_reference :transactions, :subscription, foreign_key: true, index: true
  end
end
