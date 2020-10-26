class PlantInterestsController < ApplicationController
  def create
    plant = Plant.find(params[:plant_id])
    plant_interest = PlantInterest.new(plant: plant, user: current_user)
    authorize(plant_interest)

    begin
      ActiveRecord::Base.transaction do
        plant_interest.save!
        Message.create!(sender: current_user, receiver: plant.user, content: params[:message][:content])
      end
    rescue ActiveRecord::RecordInvalid
    end
  end
end
