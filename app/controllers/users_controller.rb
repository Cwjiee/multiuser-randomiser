class UsersController < ApplicationController
  def index
    users = User.all 
    render json: users
  end

  def create
    user = User.new(username: params[:username])
    ActionCable.server.broadcast('UsersChannel', user) if user.save
    render json: user
  end

  def destroy 
    user = User.find_by(params[:id])
    user.destroy
  end

  def add_message
    user = User.find(params[:user_id])
    created_message = user.messages.create(content: params[:message])
    ActionCable.server.broadcast('MessageChannel', created_message) if user.save
    head :ok
  end
  
  def change_status; end
end
