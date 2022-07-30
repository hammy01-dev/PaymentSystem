# frozen_string_literal: true

module PlansHelper
  def admin?
    current_user.admin?
  end
end
