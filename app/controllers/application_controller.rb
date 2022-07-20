# frozen_string_literal: true
# rubocop:disable Style/Documentation
class ApplicationController < ActionController::Base
  include Pundit
  # include LoadUser
  before_action :load_user
  rescue_from Pundit::NotAuthorizedError, with: :authorization_error

  private

  def authorization_error
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def load_user
    LoadUser.user = current_user
  end
end
