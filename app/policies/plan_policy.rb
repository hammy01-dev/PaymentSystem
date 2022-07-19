# frozen_string_literal: true

class PlanPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.admin? || user.buyer?
  end

  def new?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create
    user.admin?
  end
end
