class ItemsController < ApplicationController

  def create
    @item = Item.new(params[:item])
    @item.person=current_person
    if @item.save
      flash[:notice] = "Thank you for giving things away! '#{@item.title}' can now be found by others."
      redirect_to welcome_path
    else
      flash[:error] = "We are sorry, but the item could not be created."
      redirect_to welcome_path 
    end
  end

  def show
    
  end
end
