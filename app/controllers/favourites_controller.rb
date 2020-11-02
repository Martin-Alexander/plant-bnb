class FavouritesController < ApplicationController
  def index
    authorize(Favourite)
    @favourites = policy_scope(Favourite).includes(:plant)
  end

  def destroy
    favourite = Favourite.find(params[:id])

    authorize(favourite)
    favourite.destroy

    redirect_to favourites_path
  end
end
