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

  def new
    @plant = Plant.new
    authorize(@plant)
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user
    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  def edit
    @plant = Plant.find(params[:id])
    authorize(@plant)
  end

  def update
    @plant = Plant.find(params[:id])
    authorize(@plant)

    @plant.assign_attributes(plant_params.except(:pictures))

    if @plant.valid?
      # TODO: picture specific CRUD
      if params[:plant][:pictures].present?
        @plant.pictures.purge
        @plant.pictures.attach(params[:plant][:pictures])
      end

      @plant.save
      redirect_to plant_path(@plant)
    else
      render :edit
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:title, :description, :price, :cover_photo, pictures: [])
  end
end