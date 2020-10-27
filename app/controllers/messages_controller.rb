class MessagesController < ApplicationController
  def create
    chat = Chat.find(params[:chat_id])
    message = Message.new(sender: current_user, receiver: chat.other_user, content: params[:message][:content])

    authorize(Message)

    if message.save
      other_users_chat = Chat.find_by(user: chat.other_user, other_user: current_user)
      other_users_chat.number_of_unread_messages += 1
      other_users_chat.save!

      Notification.create!(
        chat: chat.other_users_chat,
        title: "New message from #{current_user.name}: \"#{message.content}\"",
        message: message.content
      )

      redirect_to chat_path(chat)
    end
  end
end
