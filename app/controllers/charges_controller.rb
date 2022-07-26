# frozen_string_literal: true

class ChargesController < ApplicationController
  before_action :subscription_params, :load_plans
  def create
    stripe = StripeService.new(@subscription_params)
    stripe.pay(params[:stripeEmail], params[:stripeToken], @amount.to_i)
    redirect_to root_path
  end
end

  private

def subscription_params
  @subscription_params = { plan_id: params[:plan_id], user_id: current_user.id }
end

def load_plans
  plan = Plan.find(params[:plan_id])
  @amount = plan.monthly_fee
end
