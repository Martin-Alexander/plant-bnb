class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.where(user: current_user).find(params[:id])
    stream_for chat
  end
end
