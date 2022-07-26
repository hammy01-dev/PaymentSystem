# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  # include LoadUser
  before_action :load_user
  rescue_from Pundit::NotAuthorizedError, with: :authorization_error
  rescue_from ActionController::RoutingError, with: -> { content_not_found }
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def authorization_error
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def load_user
    LoadUser.user = current_user
  end

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:image, :email, :password, :current_password) }
  end
end
