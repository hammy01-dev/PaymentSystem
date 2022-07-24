# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :auth
  before_action :set_feature, only: %i[edit destroy update]
  before_action :set_plan , only: %i[index new create]

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

  def show; end

  def edit
    # @feature = Feature.find(params[:id])
  end

  def update
    # @feature = Feature.find(params[:plan_id])
    if @feature.update(feature_params)
      flash[:notice] = 'Feature Updated Successfully'
      redirect_to plan_features_path(params[:id])
    else
      flash[:alert] = "Feature could not be update"
    end

  end

  def destroy
    # @feature = Feature.find(params[:id])
    redirect_to plan_features_path(params[:plan_id]) if @feature.destroy!
  

    # redirect_to plan_features_path(params[:id])
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
    p params.require(:feature).permit(:code, :description, :name, :unit_price, :max_unit_limit)
  end
end
