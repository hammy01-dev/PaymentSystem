# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :charges, only: %i[create]

  def create
   
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id = current_user.id
    @subscription.save

    redirect_to plans_url
  end

  private

  def subscription_params
    { plan_id: params[:plan_id] }
  end

  def charges
    # redirect_to controller: 'charges', action: 'new', plan_id:params[:plan_id]
    redirect_to new_plan_charges_url and return
  end
end
