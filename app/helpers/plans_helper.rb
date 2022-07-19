# frozen_string_literal: true

module PlansHelper
  def image(plan)
    if plan.image.attached?
      image_tag plan.image.variant(resize: '50x50!').processed
    else
      flash.now[:notice] = 'No picture found'
    end
  end

  def admin?
    current_user.admin?
  end
end
