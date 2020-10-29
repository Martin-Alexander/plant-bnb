class PlantInterestsController < ApplicationController
  def create
    plant = Plant.find(params[:plant_id])
    plant_interest = PlantInterest.new(plant: plant, user: current_user)
    authorize(plant_interest)

    begin
      ActiveRecord::Base.transaction do
        plant_interest.save!
        message = Message.create!(sender: current_user, receiver: plant.user, content: params[:message][:content])

        Chat.find_or_create_by!(user: current_user, other_user: plant.user)
        other_users_chat = Chat.find_and_increment_number_of_unread_messages_or_create!(user: plant.user, other_user: current_user)
        Notification.create!(
          chat: other_users_chat,
          title: "<strong>#{current_user.name}</strong> is interested in \"<strong>#{plant.title}</strong>\"",
          message_preview: message.content
        )
      end
    rescue ActiveRecord::RecordInvalid
    end
  end
end
