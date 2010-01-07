class ItemsController < ApplicationController

  def index
    @item = Item.new
  end  

  def create
    @item = Item.new(params[:item])
    @item.person=current_person
    if @item.save
      flash[:notice] = "Thank you for giving things away! '#{@item.title}' can now be found by others."
      redirect_to items_path
    else
      render :index
    end
  end

  def show
    
  end
end
