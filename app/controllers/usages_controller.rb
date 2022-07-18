# frozen_string_literal: true

class UsagesController < ApplicationController
  def new
    @usage = Usage.new
    @user = User.all
  end

  def create
  end

end
