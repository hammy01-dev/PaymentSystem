# frozen_string_literal: true

class UsagesController < ApplicationController
  def new
    @usage = Usage.new
    @user = User.find(Subscription.subscribed_users)
    @plan = @user.first.plan - Plan.with_no_features

    @features = @plan.first.features if @plan[0]
  end

  def plan
    plan = Plan.with_no_features
    @plan = User.find(params[:id].to_i).plan - plan
    respond_to do |format|
      format.json do
        render json: @plan
      end
    end
  end

  def create
    @subscription = Subscription.where(plan_id: usage_params[:plan_id],
                                       user_id: usage_params[:user_id]).pluck(:id)[0]
    @usage = Usage.new({ subscription_id: @subscription, feature_id: usage_params[:feature_id],
                         usage: usage_params[:usage] })
    @usage
    if @usage.save!
      flash[:notice] = 'saved sucsessfully'
      redirect_to new_usage_path
    end
  end

  def features
    p 'thses are params', params[:id]
    p @feature = Plan.find(params[:id].to_i).features.as_json

    respond_to do |format|
      format.json do
        render json: @feature
      end
    end
  end
end

private

def usage_params
  params.require(:usage).permit(:feature_id, :plan_id, :usage, :user_id)
end