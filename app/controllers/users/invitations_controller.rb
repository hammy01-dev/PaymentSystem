class Users::InvitationsController < Devise::InvitationsController


  def update
    if resource.save!
      p 'hey we are in invitations controllers hurrah yah gud hu gya'

    end

  end
  def new

    p 'we are in the fukking new '
  end


end
