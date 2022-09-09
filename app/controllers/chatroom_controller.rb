class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new
    @messages = Message.all
  end

  def create 
    message = current_user.messages.build(chatroom_params)
    if message.save
      ActionCable.server.broadcast 'chatroom_channel', body: render_message(message)
    end
  end

  private 

  def chatroom_params 
    params.require(:message).permit(:body)
  end

  def render_message(message)
    render(partial: 'messages/message', locals: { message: message })
  end
end
