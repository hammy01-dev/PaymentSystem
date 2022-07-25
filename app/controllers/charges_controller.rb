class ChargesController < ApplicationController
  before_action :subscription_params, only: [:new]
  before_action :load_plans




  def create
    p customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source:params[:stripe]
  )
    p charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount.to_i,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
    if charge.id
      transaction
      User.update(:token=>customer.id)
      InvoiceMailer.new_invoice(current_user, @amount).deliver_now
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
      p @subscription  = Subscription.new(subscription_params)
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




