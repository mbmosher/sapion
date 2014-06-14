class InteractionsController < ApplicationController
  
  def new
    @interaction = Interaction.new
  end
  
  def create
    @interctions = Interaction.new(params[:interaciton].permit(:conversation_id, :user_id))
    @interaction.save
    redirect_to conversation_path(@interaction.conversation_id)
  end
  
  def destroy
    @interaction = Interaction.find(params[:conversation_id])
    @interaction.destroy
    redirect_to conversations_path
  end
  
end
