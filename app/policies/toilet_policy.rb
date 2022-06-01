class ToiletPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # Everyone is auhtorized
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def edit
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    record.user == user
  end
end
