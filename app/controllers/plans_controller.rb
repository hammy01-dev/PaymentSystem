class PlansController < ApplicationController
  before_action :authenticate_user!
  def index
    @plan = Plan.all
  end

  def new
    @plan = Plan.new
    authorize @plan
  end
end
