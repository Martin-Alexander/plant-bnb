class PlantChatsController < ApplicationController
  def index
    @plant = Plant.find(params[:id])
    
    authorize([:plants_chats, @plant])

    chats_about_the_plant = policy_scope(Chat).joins(other_user: { plant_interests: :plant }).where(plants: { id: @plant.id })

    @old_chats = chats_about_the_plant.where(number_of_unread_messages: 0)
    @new_chats = chats_about_the_plant.where("number_of_unread_messages > 0")
  end
end
