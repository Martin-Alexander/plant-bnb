class FavouritesReflex < ApplicationReflex
  def create
    favourite = Favourite.new(user: current_user, plant_id: element.dataset[:plant_id])

    if policy(favourite).create?
      favourite.save
    end
  end

  def destroy
    favourite = Favourite.find(element.dataset[:favourite_id])

    if policy(favourite).destroy?
      favourite.destroy
    end
  end
end