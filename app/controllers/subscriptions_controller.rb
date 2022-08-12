# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :subscription_params, only: %i[create]
  before_action :set_amount, only: %i[create]

  def create
    if current_user.not_verified?
      redirect_to new_plan_charges_url
    else
      transaction = TransactionService.new(@subscription_params, @amount)
      transaction.custom_transaction
      redirect_to plans_url
    end
  end

  def show
    @user = User.includes(:subscriptions, :plans)
    respond_to do |format|
      format.json do
        render json: @user.to_json(include: [:plans])
      end
      # format.html
    end
  end

  private

  def subscription_params
    @subscription_params = { plan_id: params[:plan_id], user_id: current_user.id }
  end

  def set_amount
    @amount = Plan.find(params[:plan_id]).monthly_fee
  end
end
