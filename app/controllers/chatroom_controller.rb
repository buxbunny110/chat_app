class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @messages = Message.all
  end

  def create 
    message = Message.new(chatroom_params)

    if message.save
      ActionCable.server.broadcast 'chat_room', message: message.body
    end
  end

  private 

  def chatroom_params 
    params.require(:chatroom).permit(:body)
  end
end
