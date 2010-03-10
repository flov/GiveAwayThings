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
      flash[:notice] = t('items.show.thank_you', :city => current_person.city, :item_title => @item.title)
      redirect_to welcome_path
    else
      if @item.errors.on(:title)
        flash[:error] = t('items.show.enter_title')
        render :new
      elsif @item.errors.on(:person)
        flash[:error] = t('items.show.not_yet_saved', :title => params["item"]["title"])
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
    #:title => "New Request for #{@item.title} from #{current_person.username}"
    
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
