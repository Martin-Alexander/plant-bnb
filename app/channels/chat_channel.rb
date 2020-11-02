class ChatChannel < ApplicationCable::Channel
  def self.broadcast_new_message(message)
    ChatChannel.broadcast_to(Chat.find_by(user: message.sender, other_user: message.receiver), MessagesController.render(partial: "chats/my_message", locals: { message: message }))
    ChatChannel.broadcast_to(Chat.find_by(user: message.receiver, other_user: message.sender), MessagesController.render(partial: "chats/other_users_message", locals: { message: message }))
  end

  def subscribed
    chat = Chat.where(user: current_user).find(params[:id])
    stream_for chat
  end
end
