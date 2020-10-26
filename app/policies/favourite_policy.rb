class FavouritePolicy < ApplicationPolicy
  def create?
    record.plant.public
  end

  def destroy?
    record.user == user
  end
end
