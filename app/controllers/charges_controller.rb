class ChargesController < ApplicationController
  before_action :subscription_params, only: [:new]
  before_action :load_plans




  def create
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      # source:"tok_1LOxDGFJ1WA9H4gSLVBTlgTZ"
      id: current_user.id
  )
    # charge = p Stripe::Charge.create(
    #   customer: customer.id,
    #   amount: @amount.to_i,
    #   description: 'Rails Stripe customer',
    #   currency: 'usd'
    # )
    intent =  p Stripe::PaymentIntent.create({
      customer: current_user.id,
      setup_future_usage: 'off_session',
      amount: 1099,
      currency: 'eur',
      automatic_payment_methods: {
        enabled: true,
      },
    })
    byebug

    if charge.id
      transaction
      InvoiceMailer.new_invoice(current_user, @amount).deliver_now
    end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charges_path

    rescue Stripe::APIError => e
      flash[:notice] = e.message
      byebug
      redirect_to plans_url

  end


  def transaction
    ActiveRecord::Base.transaction do
      p @subscription  = Subscription.new(subscription_params)
      byebug
      @subscription.user_id = current_user.id
      p @subscription.save!



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

  def load_plans
    plan = Plan.find(params[:plan_id])
    @amount = plan.monthly_fee

  end




