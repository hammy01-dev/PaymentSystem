class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :max_unit_limit
      t.string :unit_price
      t.string :name
      t.string :code

      t.timestamps
    end
    add_reference :features, :plan, foreign_key: true
  end
end
