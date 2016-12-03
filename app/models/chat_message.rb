class ChatMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user


  # Instead of running the ActionCable.server.broadcast code directly from the chat_messages server-side channel, this after_create_commit callback will trigger an ActiveJob whose task it is to broadcast the code.
  after_create_commit { ChatMessageBroadcastJob.perform_now self }
end
