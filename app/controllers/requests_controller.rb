class RequestsController < ApplicationController
  #for word_wrap in accept action
  include ActionView::Helpers::TextHelper
  
  def index
    @requests = Request.find(:all)
  end
  
  def show
    @request = Request.find(params[:id])
  end
  
  def accept
    @request = Request.find(params[:id])
    @message = @request.message
    @message.accepted_item = @request.item
    @accepted_item = true
    @message.title = "[GAT Accept] #{@request.owner.username} has accepted your Request. Time to pick it up!"
    @message.text = word_wrap(@message.text, 60).split("\n").map{|a| ">#{a}\n"}.join()
    @message.recipient_id = @message.author_id
    @message.text = "\n\n\n#{@request.requester.username.capitalize} wrote:\n" + @message.text
  end
  
  def reset_accept
    raise 'error'
  end
  
  def create
    @request = Request.new(params[:request])    
    if @request.save
      flash[:notice] = t('requests.show.request_sent', :username => @request.item.person.username)
      redirect_to @request.item
    else
      flash[:notice] = t('requests.show.request_already_sent', 
                       :owner => @request.item.person.username)
      redirect_to @request.item
    end
  end
  
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Successfully destroyed request."
    redirect_to messages_url
  end
  
  private
  def is_no_admin
    redirect_to root_path unless logged_in? and current_person.is_admin?
  end

end
