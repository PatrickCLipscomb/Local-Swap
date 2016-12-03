class ChatMessagesChannel < ApplicationCable::Channel
  # When the client-side subscription code gets invoked, it triggers the ChatMessagesChannel#subscribed method, which streams messages that are broadcast to this channel, passing them along to the App.room-?:chat_messages.received function.
  def subscribed
    stream_from "room-#{params['room']}:chat_messages"
  end

  # The ChatMessagesChannel#receive method receives the payload sent by App.chat_messages.send, using it to create and save a new message, and then broadcasting that new message out to all of the subscribing clients (by using the model to trigger the broadcast job :after_create). This triggers the received function of all subscription instances to fire, appending the message to the appropriate chatroom's show page.
  def receive(payload)
    ChatMessage.create(user: current_user, chat_room_id: payload["chat_room_id"], body: payload["chat_message"])
  end
end
