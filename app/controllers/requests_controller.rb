class RequestsController < ApplicationController
  #for word_wrap in accept action
  include ActionView::Helpers::TextHelper
  
  before_filter :find_request, :only => [:show, :accept, :taken, :given, :create_reference]
  
  def index
    @requests = Request.find(:all)
  end
  
  def show

  end
  
  def accept
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
      flash[:error] = t('requests.show.request_already_sent', 
                       :owner => @request.item.person.username)
      redirect_to @request.item
    end
  end
  
  def taken
    @reference = Reference.new
  end
  
  def given
    
  end
  
  def create_reference
    @reference = Reference.new(params[:reference])    
    @request.item.update_attribute(:taken_by, @reference.from
    )
    if @reference.save
      flash[:notice] = t('requests.create_reference.created', :username => @reference.to.username.capitalize)
      redirect_to person_path(@reference.to)
    else
      flash[:error] = @reference.errors.on(:to_id)
      redirect_to taken_request_path(Request.find(params[:id]))
    end
  end
  
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Successfully destroyed request."
    redirect_to messages_url
  end
  
  private
  def find_request
    @request = Request.find(params[:id])
  end

  def to_hash(&block)
    Hash[*self.collect { |v|
      [v, block.call(v)]
    }.flatten]
  end
end
