class MessagesController < ApplicationController
  #for word_wrap in reply action
  include ActionView::Helpers::TextHelper

  def index
    @messages = Message.recipient_id_equals(current_person.id).descend_by_created_at
    @unreplied_requests = current_person.unreplied_requests.size
    @unread_messages = current_person.unread_messages.size
  end
  
  def show
    @message = Message.find(params[:id])
    @message.update_attributes(:read => 1) if @message.unread?
  end
  
  def new
    id = Person.find_by_username(params[:person_id]).id
    @message = Message.new(:recipient_id => id, :author_id => current_person.id)
  end
  
  def reply
    @message = Message.find(params[:id])
    @author  = Person.find(@message.author_id)
    @message.title = "Re: #{@message.title}"
    @message.text = word_wrap(@message.text, 60).split("\n").map{|a| ">#{a}\n"}.join()
    @message.recipient_id = @message.author_id
    @message.text = "\n\n\n#{@author.username.capitalize} wrote:\n" + @message.text
  end
  
  def create
    @message = Message.new(params[:message])

    if @message.save
      if params[:reply_id]
        @reply_message = Message.find(params[:reply_id])
        @reply_message.update_attributes(:reply_id => @message.id, :replied_at => Time.now)
      end
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
