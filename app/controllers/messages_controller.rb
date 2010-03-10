class MessagesController < ApplicationController
  def index
    @messages = Message.recipient_id_equals(current_person.id)
  end
  
  def show
    @message = Message.find(params[:id])
    @message.update_attributes(:read => 1) if @message.unread?
  end
  
  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(params[:message])
    if @message.save
      flash[:notice] = "Successfully created message."
      redirect_to @message
    else
      render :action => 'new'
    end
  end
  
  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = "Successfully updated message."
      redirect_to @message
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:notice] = "Successfully destroyed message."
    redirect_to messages_url
  end
end
