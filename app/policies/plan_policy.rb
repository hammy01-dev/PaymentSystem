# frozen_string_literal: true

class PlanPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

  end

  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def show?
    user.admin?
  end


end
