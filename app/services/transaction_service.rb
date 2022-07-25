class TransactionService

  def initialize(subscription_params,amount)
    @subscription_params = subscription_params
    @amount = amount
  end

  def custom_transaction
    ActiveRecord::Base.transaction do
      p @subscription  = Subscription.new(@subscription_params)
      @subscription.save!
      Transaction.create!({:subscription_id=>@subscription.id,:amount=>@amount})
    end

    rescue ActiveRecord::RecordInvalid
      puts "Oops. We tried to do an invalid operation!"
  end
end

