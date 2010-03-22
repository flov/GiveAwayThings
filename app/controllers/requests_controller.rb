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
    @request.accepted = true
    @message = @request.message # for form field
    @message ||= Message.new 
    @message.title = t('requests.show.deny', :user => @request.owner.username)
    @message.text = word_wrap(@message.text, 60).split("\n").map{|a| ">#{a}\n"}.join() unless @message.new_record?
    @message.recipient_id = @message.author_id
    @message.text = t('requests.show.accept', :user => @request.requester.username.capitalize) + @message.text unless @message.new_record?
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
