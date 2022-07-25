# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_user!, :auth
  before_action :set_plan, only: %i[edit update destroy]

  def index
    @plans = Plan.where.not(id: Subscription.current_users(current_user.id).pluck(:plan_id))
    @plans.preload(:features)
  end

  def new
    @plan = Plan.new
  end

  def edit; end

  def destroy
    flash[:notice] = if @plan.destroy
                       'sucessfully deleted the Plan'

                     else
                       'unableto  delete the Plan'

                     end
    redirect_to root_path
  end

  def create
    @plan = Plan.new(plan_params)
    # @plan.image.attach(params[:plan][:images])
    @plan.save

    if @plan.valid?

      redirect_to root_path
    else

      flash[:errors] = @plan.errors.full_messages
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

  def charges
    redirect_to new_charges_path
  end
end
