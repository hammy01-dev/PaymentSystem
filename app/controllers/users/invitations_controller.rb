# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[name email password image])
      # devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :email, :password,:image])
    end
  end
end
