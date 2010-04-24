class ItemsController < ApplicationController
  # for truncate method in controller
  include ActionView::Helpers::TextHelper
  
  def index
    # params[:search] ||= ""
    # params["search"]["title_like"] = "" if params["search"]["title_like"] == "Search item."
    # params["search"][""]
    # @search = Item.search(params[:search])
    @items = Item.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def search
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
    @request.build_message(:title => t('items.show.gat_request', :title => truncate(@item.title)))
    
    @person = @item.person
    @username = @item.person.username
    @references = @person.references
  end
  
  private
  def redirect_if_not_logged_in(flash_msg)
    unless logged_in?
      flash[:error] = flash_msg
      redirect_to signup_path 
    end
  end
end
