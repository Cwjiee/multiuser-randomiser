class MessagesController < ApplicationController
  def index 
    messages = Message.all 
    render json: messages
  end

  def destroy 
    message = Message.find_by(params[:id])
    message.destroy 
  end
end
