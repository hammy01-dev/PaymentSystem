# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.date :billing_date, default: -> { 'CURRENT_DATE' }

      t.timestamps
    end

    add_reference :subscriptions, :user, foreign_key: true, index: true, null: false
    add_reference :subscriptions, :plan, foreign_key: true, index: true, null: false
  end
end
