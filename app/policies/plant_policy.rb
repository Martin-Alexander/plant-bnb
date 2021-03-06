class PlantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(private: false)
    end
  end

  def index?
    true
  end

  def show?
    record.public || record.user == user
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
