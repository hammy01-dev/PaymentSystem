# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_user!, :auth
  def index
    @plans = Plan.where.not(id: Subscription.current_users(current_user.id).pluck(:plan_id))
    @plans.preload(:features)
  end

  def new
    @plan = Plan.new
    authorize @plan
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.image.attach(params[:plan][:images])
    @plan.save!

    if @plan.valid?

      redirect_to root_path
    else

      flash[:errors] = @plan.errors.full_messages
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee)
  end

  def auth
    authorize Plan
  end
end
