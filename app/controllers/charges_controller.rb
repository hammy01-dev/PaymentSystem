class ChargesController < ApplicationController
  before_action :subscription_params, only: [:new]


  def new
    plan = Plan.find(params[:plan_id])
    @amount = plan.monthly_fee
  end

  def create
    plan = Plan.find(params[:plan_id])
    @amount = plan.monthly_fee
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
  )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount.to_i,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
    if charge.id
      transaction
    end
    # Transaction.create(amount:@amount, billing_day:Date.today, buyer_id:current_user.id)
    # SubscribedPlan.create(plan_id:plan.id, buyer_id:current_user.id)
    # Usage.create(units_used:plan.features.first.max_unit_limit, feature_id:plan.features.first.id, buyer_id:current_user.id)
    # SubscribeMailer.subscription_email(current_user, plan).deliver_now!
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charges_path
  end

  def transaction
    ActiveRecord::Base.transaction do
      p @subscription  = Subscription.new(subscription_params)
      @subscription.save!



      Transaction.create!({:subscription_id=>@subscription.id,:amount=>@amount})
    end

    rescue ActiveRecord::RecordInvalid
      puts "Oops. We tried to do an invalid operation!"

    end
  end

  private

  def subscription_params
    params.permit(:plan_id)
  end




