class FeaturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin?
  end

  def new?
    puts 'hello'
    user.admin?
  end
  def show?
    user.admin?

  end

end
