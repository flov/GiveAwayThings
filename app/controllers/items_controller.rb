class ItemsController < ApplicationController
  # for truncate method in controller
  include ActionView::Helpers::TextHelper
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]
  before_filter :redirect_if_not_logged_in, :only => [:edit, :update, :destroy]
  before_filter :redirect_if_not_owner_of_item, :only => [:edit, :update, :destroy]

  def index
    if params[:q].nil? || params[:q] == 'Type in city.'
      @items = Item.not_accepted_not_taken.paginate :page => params[:page], :order => 'created_at DESC'
    elsif params[:search_by] == 'city' 
      @items = Item.not_accepted_not_taken.search_by_city(params[:q], params[:page])
    elsif params[:search_by] == 'title'
      @items = Item.not_accepted_not_taken.search_by_title(params[:q], params[:page])
    else
      @items = Item.not_accepted_not_taken.paginate :page => params[:page], :order => 'created_at DESC'
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
    if logged_in?
      @request.build_message(:title => t('items.show.gat_request', :username => current_person.username, :title => truncate(@item.title)))
    end
    @person = @item.person
    @username = @item.person.username
    @references = @person.references
  end
  
  def edit

  end
  
  def update
    if @item.update_attributes(params[:item])
      flash[:notice] = t('items.update.updated')
      redirect_to @item
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Successfully destroyed #{@item.title}."
    redirect_to person_path(current_person)
  end
  
  private
  def find_item
    @item = Item.find(params[:id])
  end
  
  def redirect_if_not_owner_of_item
    if @item.person != current_person
      flash[:error] = t('flash.no_permission')
      redirect_to item_path(@item)
    end
  end
end
