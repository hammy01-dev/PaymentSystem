# frozen_string_literal: true

class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :paymet_verified, :integer, default: 0
    add_column :users, :stripe_token, :string
  end
end
