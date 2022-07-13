class PlansController < ApplicationController
  before_action :authenticate_user!
  def index
    @plan = Plan.all
  end
end
