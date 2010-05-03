class ItemsController < ApplicationController
  # for truncate method in controller
  include ActionView::Helpers::TextHelper
  before_filter :find_item, :only => [:show, :edit]
  before_filter :redirect_if_not_logged_in, :only => :edit
  before_filter :redirect_if_not_owner_of_item, :only => :edit

  def index
    # params[:search] ||= ""
    # params["search"]["title_like"] = "" if params["search"]["title_like"] == "Search item."
    # params["search"][""]
    # @search = Item.search(params[:search])
    if params[:q].nil?
      @items = Item.taken_by_nil.paginate :page => params[:page], :order => 'created_at DESC'
    elsif params[:search_by] == 'city' 
      @items = Item.taken_by_nil.search_by_city(params[:q], params[:page])
    elsif params[:search_by] == 'title'
      @items = Item.taken_by_nil.search_by_title(params[:q], params[:page])
    else
      @items = Item.taken_by_nil.paginate :page => params[:page], :order => 'created_at DESC'
    end
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
    @request.build_message(:title => t('items.show.gat_request', :username => current_person.username, :title => truncate(@item.title)))
    
    @person = @item.person
    @username = @item.person.username
    @references = @person.references
  end
  
  def edit

  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = t('people.update.updated')
      redirect_to @item
    else
      render :action => 'edit'
    end
  end
  
  private
  def find_item
    @item = Item.find(params[:id])
  end
  
  def redirect_if_not_logged_in
    unless logged_in?
      flash[:error] = t('defaults.not_logged_in')
      redirect_to signup_path 
    end
  end
  
  def redirect_if_not_owner_of_item
    if @item.person != current_person
      flash[:error] = t('defaults.no_permission')
      redirect_to signup_path 
    end
  end
end
