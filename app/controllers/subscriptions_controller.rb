class SubscriptionsController < ApplicationController

  def new

  end
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user_id =current_user.id
    @subscription.save!


  end

  private
  def subscription_params

    {plan_id: params[:plan_id]}
  end
end
