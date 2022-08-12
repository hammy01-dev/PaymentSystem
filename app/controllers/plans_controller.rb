# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_user!, :auth, only: %i[edit update destroy new create]
  before_action :set_plan, only: %i[edit update destroy]

  def index
    # @plans = Plan.where.not(id: Subscription.current_users(current_user.id).pluck(:plan_id))
    @plans = Plan.all
    @plans.preload(:features)
    respond_to do |format|
      format.json { render json: @plans.to_json(include: [:features]) }
      format.html
    end
  end

  def new
    @plan = Plan.new
  end

  def destroy
    flash[:notice] = 'sucessfully deleted the Plan' if @plan.destroyed?
    redirect_to root_path
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.valid? && @plan.save

      redirect_to root_path
    else

      flash[:errors] = @plan.errors.full_messages
      render :new
    end
  end

  def update
    if @plan.update(plan_params)
      flash[:notice] = 'Plan Updated Successfully'
      redirect_to root_path
    else
      flash.now[:notice] = 'could not update the plan'
      render :edit
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee)
  end

  def auth
    authorize Plan
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
