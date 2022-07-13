# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end
end
