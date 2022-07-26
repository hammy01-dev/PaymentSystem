# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_amount, only: %i[create]
  before_action :set_amount, only: %i[create]

  def create
    if current_user.not_verified?
      redirect_to new_plan_charges_url
    else
      transaction = TransactionService.new(@subscription_params, @amount)

      redirect_to plans_url
    end
  end

  def show
    @subscription = Subscription.preload(:plan)
  end

  private

  def subscription_params
    @subscription_params = { plan_id: params[:plan_id], user_id: current_user.id }
  end

  def set_amount
    @amount = Plan.find(params[:plan_id]).monthly_fee
  end
end
