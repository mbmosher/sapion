class ConversationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @mycons = current_user.conversations.all.uniq!
    # @mycons = Conversation.where("initiator = ?", current_user.id)
    # @otherscons = Conversation.where("mark = ?", current_user.id)
    # @allcons = (@mycons + @othercons).order(created_at: :desc)
    # @orderedcons = @allcons.order(created_at: :desc)
    # plus conversations belong to other users that include this user.
  end
  
  def create
    @profile = Profile.find(params[:id])
    
    if current_user.conversations.last && DateTime.now - 1.day > current_user.conversations.last.created_at
      redirect_to profile_path(@profile)
    end
    
    @converse = Conversation.new()
    @converse.initiator = current_user.id
    @converse.mark = @profile.user_id
    @converse.save
    
    @message = Message.new
    @message.conversation_id = @converse.id
    @message.user_id = @profile.user_id
    @message.save
    
    @message2 = Message.new
    @message2.conversation_id = @converse.id
    @message2.user_id = current_user.id
    @message2.save
    
    redirect_to conversation_path(@converse)
  end
  
  def destroy
    @converse = Conversation.find(params[:id])
    @converse.destroy
    redirect_to conversations_path
  end
  
  def show
    @converse = Conversation.find(params[:id])
  end
end