class ItemsController < ApplicationController
  
  #before_filter :redirect_if_not_logged_in, :only => :show
  
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
    @item.person_id = current_person.id if logged_in?
    @item.address_id = current_person.address.id if logged_in?
    if @item.save
      flash[:notice] = "Thank you for giving things away!<br>'#{@item.title}' can now be found by others in #{current_person.address.city}."
      redirect_to welcome_path
    else
      if @item.errors.on(:title)
        flash[:error] = "Please enter a title for the item"
        render :new
      elsif @item.errors.on(:person)
        flash[:error] = "#{params["item"]["title"]} has not yet been saved, log in or sign up to save it."
        @person = Person.new
        @person.build_address.build_city.build_country
        render 'people/new'
      end
      flash.discard
    end    
  end

  def show
    @item = Item.find(params[:id])
    @request = Request.new
    @request.build_message(:title => "New Request for #{@item.title} from #{current_person.username}", 
                           :person_id => current_person.id)

    @person = @item.person
    @username = @item.person.username
    @items_given = @person.items.taken_by_does_not_equal 0
    @items_taken = @person.items_taken
    @items_offered = @person.items.accepted_equals 0
    
  end
  
  private
  def redirect_if_not_logged_in(flash_msg)
    unless logged_in?
      flash[:error] = flash_msg
      redirect_to signup_path 
    end
  end
end
