class PlantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    authorize(Plant)
    @plants = policy_scope(Plant).includes(:user)
  end

  def show
    @plant = Plant.find(params[:id])
    authorize(@plant)
  end
end