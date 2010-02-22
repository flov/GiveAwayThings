class RequestsController < ApplicationController
  
  before_filter :is_no_admin, :except => [:create]
  
  def index
    @requests = Request.find(:all)
  end
  
  def show
    @request = Request.find(params[:id])
  end
  
  def create
    @request = Request.new(params[:request])
    @request.person_id = current_person.id
    
    if @request.save
      flash[:notice] = "<h2>Request has been sent.</h2>#{@request.item.person.username} will be notified"
      redirect_to @request.item
    else
      flash[:error] = "<h2>You already sent a request for this thing.</h2>If you want to remind the owner of your request, you should send him a simple message."
      redirect_to @request.item
    end
  end
  
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Successfully destroyed request."
    redirect_to requests_url
  end
  
  private
  def is_no_admin
    redirect_to root_path unless logged_in? and current_person.is_admin?
  end

end
