class AddValidation < ActiveRecord::Migration[5.2]
  def change
    change_column :features, :plan_id, :integer, null: false
  end

end
