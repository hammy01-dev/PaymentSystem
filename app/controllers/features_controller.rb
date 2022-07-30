# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :auth
  before_action :set_feature, only: %i[edit destroy update]
  before_action :set_plan, only: %i[index new create]

  def index
    @feature = Feature.where(plan_id: params[:plan_id])
  end

  def new
    @features = @plan.features.build
  end

  def create
    @features = @plan.features.new(feature_params)
    if @features.save
      flash[:notice] = 'Feature Created Successfully'

      redirect_to plan_features_url
    else
      flash.now[:notice] = @features.errors.messages
      render :new
    end
  end

  def update
    if @feature.update(feature_params)

      flash[:notice] = 'Feature Updated Successfully'
      redirect_to plan_features_path(params[:id])
    else
      flash[:alert] = 'Feature could not be update'
      render :edit
    end
  end

  def destroy
    redirect_to [params[:plan_id], Plan] if @feature.destroy
  end

  def auth
    authorize Feature
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def feature_params
    params.require(:feature).permit(:code, :description, :name, :unit_price, :max_unit_limit)
  end
end
