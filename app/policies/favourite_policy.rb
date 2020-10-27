class FavouritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    true
  end

  def create?
    record.plant.public
  end

  def destroy?
    record.user == user
  end
end
