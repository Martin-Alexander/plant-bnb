class PlantInterestsController < ApplicationController
  def create
    plant = Plant.find(params[:plant_id])
    plant_interest = PlantInterest.new(plant: plant, user: current_user)
    authorize(plant_interest)

    begin
      ActiveRecord::Base.transaction do
        plant_interest.save!
        Message.create!(sender: current_user, receiver: plant.user, content: params[:message][:content])

        Chat.find_or_create_by!(user: current_user, other_user: plant.user)
        Chat.find_and_increment_number_of_unread_messages_or_create!(user: plant.user, other_user: current_user)
      end
    rescue ActiveRecord::RecordInvalid
    end
  end
end
