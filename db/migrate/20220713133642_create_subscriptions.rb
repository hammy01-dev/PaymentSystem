# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.timestamps
      t.date :billing_date, default: -> { 'CURRENT_DATE' }
    end
    add_reference :subscriptions, :user, foreign_key: true, index: true
    add_reference :subscriptions, :plan, foreign_key: true, index: true
  end
end
