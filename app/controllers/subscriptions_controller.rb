# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def new; end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id = current_user.id
    @subscription.save!
   
    redirect_to plans_url
  end

  private

  def subscription_params
    { plan_id: params[:plan_id] }
  end
end
