class MessagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @message = Message.new
  end
  
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(params[:message].permit(:text))
    @message.user_id = current_user.id
    @message.save
    redirect_to conversation_path(@conversation)
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to conversations_path
  end
  
end
