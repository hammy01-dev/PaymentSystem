class FeaturesController < ApplicationController
  def index
    @feature = Feature.where(plan_id:params[:plan_id])
  end
  def new
    @plan = Plan.find(params[:plan_id])
    @features = Feature.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @feature = @plan.features.create(feature_params)
    redirect_to plan_features_url
  end

  def show
  end


  def edit
    @plan = Plan.find(params[:plan_id])

    @feature = Feature.find(params[:id])
  end

  def update
    # @plan = Plan.find(params[:plan_id])
    # @feature = @plan.features.update!(feature_params)
    # redirect_to plan_features_url

  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy

  end

  private
  def feature_params
    p params
    p params.require(:feature).permit(:code, :description, :name, :unit_price, :max_unit_limit)
  end
end
