# frozen_string_literal: true

class StripeService
  def initialize(subscription_params)
    @subscription_params = subscription_params
  end

  def pay(stripe_email, stripe_token, amount)
    @amount = amount

    customer = Stripe::Customer.create(
      email: stripe_email,
      source: stripe_token
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
    byebug
    if charge.id
      transaction
      User.update(stripe_token: customer.id, paymet_verified: 1)
      # p InvoiceMailer.new_invoice(current_user, @amount).deliver_now
    else
      p 'we are in else'
      redirect_to root_path
    end
  rescue Stripe::CardError => e
    p e
    flash[:error] = e.message
    redirect_to root_path
  rescue Stripe::APIError => e
    p e
    flash[:notice] = e.message
    redirect_to root_path
  end

  def transaction
    ActiveRecord::Base.transaction do
      @subscription = Subscription.new(@subscription_params)
      @subscription.save
      Transaction.create({ subscription_id: @subscription.id, amount: @amount })
    end
  rescue ActiveRecord::RecordInvalid
    'Oops. We tried to do an invalid operation!'
  end
end
