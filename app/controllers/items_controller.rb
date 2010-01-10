class ItemsController < ApplicationController
  def index
    @items = Item.search(params[:search])
  end

  def create
    redirect_to signup_path unless logged_in
    @item = Item.new(params[:item])
    @item.person_id = current_person.id
    @item.address_id = current_person.addresses.first.id
    if @item.save
      flash[:notice] = "Thank you for giving things away!<br>'#{@item.title}' can now be found by others in #{current_person.addresses.last.city}."
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
