# frozen_string_literal: true

class TransactionService
  def initialize(subscription_params, amount)
    @subscription_params = subscription_params
    @amount = amount
  end

  def custom_transaction
    ActiveRecord::Base.transaction do
      @subscription = Subscription.new(@subscription_params)
      @subscription.save
      Transaction.create({ subscription_id: @subscription.id, amount: @amount })
    end
  rescue ActiveRecord::RecordInvalid
    puts 'Oops. We tried to do an invalid operation!'
  end

  def sql_statements
    @sql1 = "DROP VIEW IF EXISTS subscribe;
    CREATE VIEW subscribe AS
    select s.user_id, p.monthly_fee, s.id as s_id, p.id as plan_id, u.email,p.name as plan_name ,u.name
    from subscriptions as s, plans as p,users as u
    where s.plan_id = p.id and u.id=s.user_id ;

    DROP VIEW IF EXISTS feature;
    CREATE VIEW feature AS
    select u.subscription_id, u.usage,f.unit_price,f.name as feature_name,f.max_unit_limit,f.id as feature_id
    from usages as u , features as f
    where u.feature_id = f.id;
    select *
    from feature;

    select *
    from feature as f , subscribe as s
    where f.subscription_id = s.s_id;"
  end

  def execute
    sql_statements
    @subscription = ActiveRecord::Base.connection.execute(@sql1).as_json
  end
end
