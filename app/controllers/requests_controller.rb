class RequestsController < ApplicationController
  
  before_filter :is_no_admin
  
  def index
    @requests = Request.find(:all)
  end
  
  def show
    @request = Request.find(params[:id])
  end
  
  def new
    @request = Request.new
  end
  
  def create
    @request = Request.new(params[:request])
    if @request.save
      flash[:notice] = "Successfully created request."
      redirect_to @request
    else
      render :action => 'new'
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
