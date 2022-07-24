# frozen_string_literal: true
module Transactions

  def get_subscriptions
    # @subscription = Subscription.where("created_at <=? and created_at >=? ", Time.now - 2*60*60 ,Time.now-12*60*60).pluck(:id)
    p sql_statements

    p @subscription = ActiveRecord::Base.connection.execute(@sql1).as_json
    fee(@subscription)
  end

  def fee(data)
    result = {}
    (0..data.length - 1).each do |i|
      if result[data[i]['user_id']]
        if data[i]['usage'].to_i > data[i]['max_unit_limit'].to_i
          result[data[i]['user_id']] =
            (data[i]['usage'].to_i - data[i]['max_unit_limit'].to_i) * data[i]['unit_price'].to_i
        end
      else
        result[data[i]['user_id']] = if data[i]['usage'].to_i > data[i]['max_unit_limit'].to_i
                                       (data[i]['usage'] - data[i]['max_unit_limit']) * data[i]['unit_price'].to_i
                                     else
                                       data[i]['monthly_fee']
                                     end
      end
    end
    result
  end

  def sql_statements
    @sql1 = "DROP VIEW IF EXISTS subscribe;
      CREATE VIEW subscribe AS
      select s.user_id, p.monthly_fee, s.id as s_id, p.id as plan_id,u.email,p.name as plan_name
      from subscriptions as s, plans as p,users as u
      where s.plan_id = p.id and u.id=s.user_id and s.plan_id IN
       (
          SELECT  s.plan_id
          FROM    subscriptions as s
          Where created_at <=  NOW() - '1day'::INTERVAL
      );

      DROP VIEW IF EXISTS feature;
      CREATE VIEW feature AS
      select u.subscription_id, f.unit_price, u.usage,f.name,f.max_unit_limit, f.id as feature_id
      from usages as u , features as f
      where u.feature_id = f.id;

      select *
      from feature as f , subscribe as s
      where f.subscription_id = s.s_id"
  end

end
