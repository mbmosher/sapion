class ConversationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @mycons = current_user.conversations.all #.uniq!
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
    
    Interaction.create(:conversation_id => @converse.id, :user_id => current_user.id)
    Interaction.create(:conversation_id => @converse.id, :user_id => @profile.user_id)
    
=begin
    @message = Message.new
    @message.conversation_id = @converse.id
    @message.user_id = @profile.user_id
    @message.save
    
    @message2 = Message.new
    @message2.conversation_id = @converse.id
    @message2.user_id = current_user.id
    @message2.save
=end
    redirect_to conversation_path(@converse)
  end
  
  def destroy
    @converse = Conversation.find(params[:id])
    @converse.destroy
    redirect_to conversations_path
  end
  
  def show
    @converse = Conversation.find(params[:id])
    
    starters = [
                "If you were in a circus, what would your job be?",
                "Tell me about something that made you laugh this week.",
                "What was the most exciting thing you did last week?",
                "If you weren't in your current job, what would you be doing?",
                "What is the worst advice that you got that you actually listened to?",
                "What's the worst thing you can say on a first date?",
                "What are things that you should not say at your own wedding?",
                "If you had $10 million, would you still be working/going to school?",
                "What would you do with a blank check?",
                "Would you rather be rich and never find true love or be poor and find true love?",
                "Where was the last place you went on vacation?",
                "Where do you plan on going for your next vacation?",
                "If you could live anywhere in the world, where would it be?",
                "Who do you look up to?",
                "Do you sleep with a stuffed animal?",
                "Do you believe in luck?",
                "Want to get coffee this week?",
                "What is your favorite board game?",
                "What is the most valuable thing that you own?",
                "Have you ever cried, or peed, because you were so happy?",
                "If you were stranded on a deserted island and you could have only 1 item, what would it be?",
                "If you had the chance to start any business, what would it be?",
                "If you could send a message to the whole world, what would it be?",
                "What is more important to you, friends or family?",
                "What is something you would like to become better at?",
                "What do you usually eat for breakfast?"
               ]
    @suggest = starters.sample
  end
end
