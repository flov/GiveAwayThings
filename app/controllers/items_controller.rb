class ItemsController < ApplicationController

  before_filter :redirect_if_not_logged_in, :only => [:create]

  def index
    params["search"]["title_like"] = "" if params["search"]["title_like"] == "Search item."
    @search = Item.search(params[:search])
    @items = @search.all
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    @item.person_id = current_person.id
    @item.address_id = current_person.address.id
    if @item.save
      flash[:notice] = "Thank you for giving things away!<br>'#{@item.title}' can now be found by others in #{current_person.address.city}."
      redirect_to welcome_path
    else
      render :new
    end    
  end

  def show
    @item = Item.find(params[:id])
    @request = Request.new

    @person = @item.person
    @username = @item.person.username
    @items_given = @person.items.taken_by_does_not_equal 0
    @items_taken = @person.items_taken
    @items_offered = @person.items.accepted_equals 0
    
  end
  
  private
  def redirect_if_not_logged_in
    redirect_to signup_path unless logged_in?
  end
end
