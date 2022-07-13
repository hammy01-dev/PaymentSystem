
class User::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  def new
    puts  'we are in new file action'.colorize(:red)

  end
  def create
    # User.invite!(configure_permitted_parameters2)
    puts 'we are in create action'.colorize(:red)
  end
  def edit
    # User.accept_invitation!(configure_permitted_parameters)
    puts 'we are in edit action'.colorize(:red)

  end

  def update
    # User.accept_invitation!(configure_permitted_parameters)

  end



  protected

  # Permit the new params here.
  def configure_permitted_parameters
    puts '----------------------------------------------------------------->>>>>>>>>>>',params.colorize(:red)
    p devise_parameter_sanitizer.permit(:accept_invitation, keys: [:password_confirmation,:password,:role])
    # p devise_parameter_sanitizer.permit(:invite, keys: [:password_confirmation,:password,:role])
  end



end

