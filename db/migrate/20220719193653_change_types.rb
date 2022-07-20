class ChangeTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :plans, :monthly_fee, 'numeric USING CAST(monthly_fee AS numeric)'
    change_column :usages, :usage, 'numeric USING CAST(usage AS numeric)'
    change_column :features, :unit_price,'numeric USING CAST(unit_price AS numeric)'
    change_column :features,:max_unit_limit, 'numeric USING CAST(max_unit_limit AS numeric)'
  end
end
