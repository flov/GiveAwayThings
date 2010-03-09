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
    if @request.save
      flash[:notice] = t('requests.show.request_sent', :username => @request.item.person.username)
      redirect_to @request.item
    else
      flash[:notice] = t('requests.show.request_already_sent')
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
