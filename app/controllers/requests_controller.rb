class RequestsController < ApplicationController
  #for word_wrap in accept action
  include ActionView::Helpers::TextHelper
  
  before_filter :find_request, :only => [:show, :accept, :taken, :given]
    
  def accept
    @request.accepted = true
    @message = @request.message # for form field
    @message ||= Message.new 
    @message.title = t('requests.show.accept2', :user => @request.owner.username, :item => @request.item.title[0..30])
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
    if not @request.owners_reference(current_person).nil?
      @reference = @request.owners_reference(current_person)
    else
      @reference = Reference.new
    end
  end
  
  def given
    
  end
  
  def create_reference
    @request = Request.find(params[:id]) if params[:taken_by]
    @reference = Reference.new(params[:reference])
    if Reference.exists? params["reference"]["id"]
      flash[:notice] = t('requests.create_reference.updated')
      @reference.update_reference(params[:reference][:id], params[:reference])
      @request.mark_item_as_taken(params[:taken_by]) if params[:taken_by]
      @request.archive_request if params[:taken_by]
      redirect_to person_path(@reference.to)
    elsif @reference.save
      flash[:notice] = t('requests.create_reference.created', :username => @reference.to.username.capitalize)
      @request.archive_request if params[:taken_by]
      @request.mark_item_as_taken(params[:taken_by]) if params[:taken_by]
      redirect_to person_path(@reference.to)
    else
      raise 'error'
      flash[:error] = @reference.errors.on(:to_id)
      redirect_to person_path(Person.find_by_username(params[:id]))
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
    unless Request.exists?(params[:id])
      flash[:error] = 'This Request does not exist. Maybe it has already been deleted.'
      redirect_to '/' 
    end
    @request = Request.find(params[:id])
  end

  def to_hash(&block)
    Hash[*self.collect { |v|
      [v, block.call(v)]
    }.flatten]
  end
end
