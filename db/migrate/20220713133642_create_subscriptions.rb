class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.timestamps
    end
    add_reference :subscriptions, :user, foreign_key: true
    add_reference :subscriptions, :plan, foreign_key: true
  end
end
