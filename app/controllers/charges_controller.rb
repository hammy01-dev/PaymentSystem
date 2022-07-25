# frozen_string_literal: true

class ChargesController < ApplicationController
  before_action :subscription_params, only: [:new]
  before_action :load_plans

  def create
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
      p 'we are in if '
      p transaction
      p User.update(stripe_token: customer.id, paymet_verified: 1)
      p InvoiceMailer.new_invoice(current_user, @amount).deliver_now
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
      p @subscription = Subscription.new(subscription_params)
      @subscription.user_id = current_user.id
      p @subscription.save!
      Transaction.create!({ subscription_id: @subscription.id, amount: @amount })
    end
  rescue ActiveRecord::RecordInvalid
    puts 'Oops. We tried to do an invalid operation!'
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
