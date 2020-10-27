class ChatsController < ApplicationController
  def index
    authorize(Chat)

    @old_chats = policy_scope(Chat).where(number_of_unread_messages: 0)
    @new_chats = policy_scope(Chat).where("number_of_unread_messages > 0")
  end

  def show
    @chat = Chat.find(params[:id])
    authorize(@chat)

    messages = @chat.messages.order(created_at: :asc).includes(:receiver, :sender)
    your_plant_interests = policy_scope(PlantInterest).joins(:plant).where(user: current_user).includes(:user, :plant)
    plant_interests_of_other_user = policy_scope(PlantInterest).joins(:plant).where(plants: { user: current_user }).includes(:user, :plant)
    plant_interests = your_plant_interests.or(plant_interests_of_other_user)

    @messages_and_plant_interest = (messages.to_a + plant_interests.to_a).sort_by { |record| record.created_at }
  end
end
