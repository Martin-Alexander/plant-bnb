class FavouritesController < ApplicationController
  def index
    authorize(Favourite)
    @favourites = policy_scope(Favourite).includes(:plant)
  end

  def create
    favourite = Favourite.new(user: current_user, plant_id: params[:plant_id])
    authorize(favourite)
    favourite.save
  end

  def destroy
    favourite = Favourite.find(params[:id])
    authorize(favourite)
    favourite.destroy
  end
end
