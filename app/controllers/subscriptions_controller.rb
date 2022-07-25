# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_amount, only: %i[create]
  before_action :set_amount, only: %i[create]

  def create
    if current_user.not_verified?
      redirect_to new_plan_charges_url
    else
      subscription_params
      transaction = TransactionService.new(@subscription_params, @amount)
      p 'this is return ', return1 = transaction.custom_transaction
      redirect_to plans_url
    end
  end

  private

  def subscription_params
    @subscription_params = { plan_id: params[:plan_id], user_id: current_user.id }
  end

  def set_amount
    @amount = Plan.find(params[:plan_id]).monthly_fee
  end

  def show; end
end
