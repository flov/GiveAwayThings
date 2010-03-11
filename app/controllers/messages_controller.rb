class MessagesController < ApplicationController
  def index
    @messages = Message.recipient_id_equals(current_person.id)
  end
  
  def show
    @message = Message.find(params[:id])
    @message.update_attributes(:read => 1) if @message.unread?
  end
  
  def new
    @message = Message.new(:recipient_id => params[:person_id])
  end
  
  def reply
    @message = Message.find(params[:id])
    @message.title= "Re: #{@message.title}"
    @message.recipient_id = @message.author_id
  end
  
  def create
    @message = Message.new(params[:message])
    if @message.save
      flash[:notice] = "Message has been sent."
      redirect_to messages_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:notice] = "Successfully destroyed message."
    redirect_to messages_url
  end
end
