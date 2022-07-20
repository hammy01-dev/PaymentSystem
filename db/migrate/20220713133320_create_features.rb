# frozen_string_literal: true

class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.integer :max_unit_limit, null:false
      t.integer :unit_price, null:false
      t.string :name, null:false
      t.integer :code, null: false

      t.timestamps
    end
    add_reference :features, :plan, foreign_key: true, index:true
  end
end
