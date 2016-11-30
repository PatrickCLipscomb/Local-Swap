class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.find_by(id: params[:slug])
    @chat_message = ChatMessage.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
