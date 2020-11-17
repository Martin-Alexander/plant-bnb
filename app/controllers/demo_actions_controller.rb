class DemoActionsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def steph_response
    steph = User.find_by_name("Stephane")
    richard = User.find_by_name("Richard")
    steph_chat = steph.chats.first
    richard_chat = richard.chats.first

    message = Message.create!(sender: steph, receiver: richard, content: "Yup! That works fine for me. See you then.")

    richard_chat.number_of_unread_messages += 1
    richard_chat.save!

    Notification.create!(
      chat: richard_chat,
      title: "New message from <strong>#{steph.name}</strong>",
      message_preview: message.content
    )

    ChatChannel.broadcast_to(richard_chat, "");

    redirect_to demo_actions_path
  end

  def alex_proposal
    alex = User.find_by_name("Alex")

    plant = Plant.find_by_title("Potted Dracena (Dragon Plant)")
    plant_interest = PlantInterest.new(plant: plant, user: alex)

    begin
      ActiveRecord::Base.transaction do
        plant_interest.save!
        message = Message.create!(sender: alex, receiver: plant.user, content: "Hey! Could I come by Saturday morning at 10 for this? Otherwise I can do anytime after 6 PM. Thanks!")

        Chat.find_or_create_by!(user: alex, other_user: plant.user)
        other_users_chat = Chat.find_and_increment_number_of_unread_messages_or_create!(user: plant.user, other_user: alex)
        Notification.create!(
          chat: other_users_chat,
          title: "<strong>#{alex.name}</strong> is interested in \"<strong>#{plant.title}</strong>\"",
          message_preview: message.content
        )
      end
    rescue ActiveRecord::RecordInvalid
    end

    redirect_to demo_actions_path
  end
end
