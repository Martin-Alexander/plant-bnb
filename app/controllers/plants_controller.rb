class PlantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    authorize(Plant)
    @plants = policy_scope(Plant).includes(:user)
  end

  def show
    @plant = Plant.find(params[:id])
    @plant_interest = PlantInterest.find_or_initialize_by(plant: @plant, user: current_user)
    @users_other_plants = policy_scope(@plant.user.plants).where.not(id: @plant.id).includes(:user)
    authorize(@plant)
  end
end