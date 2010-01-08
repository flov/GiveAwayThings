class ItemsController < ApplicationController
  def index
    @items = Item.search(params[:search])
  end

  def create
    @item = Item.new(params[:item])
    @item.person_id = current_person.id
    @item.address_id = current_person.addresses.first.id
    if @item.save
      flash[:notice] = "Thank you for giving things away! '#{@item.title}' can now be found by others."
      redirect_to welcome_path
    else
      render :text => 'failed'
    end
  end

  def search_city
    
  end

  def new
    
  end

  def show
    
  end
end
