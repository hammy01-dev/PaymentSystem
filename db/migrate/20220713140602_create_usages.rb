# frozen_string_literal: true

class CreateUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :usages do |t|
      t.integer :usage

      t.timestamps
    end
    add_reference :usages, :subscription, foreign_key: true
    add_reference :usages, :feature, foreign_key: true
  end
end
