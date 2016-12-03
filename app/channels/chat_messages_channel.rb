class ChatMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room-#{params['room']}:chat_messages"
  end

  def receive(payload)
    ChatMessage.create(user: current_user, chat_room_id: payload["chat_room_id"], body: payload["chat_message"])
  end
end
