class ItemsController < ApplicationController

  def create
    @item = Item.new(params[:item])
    if @item.save
      flash[:notice] = "Thank you for giving things away! '#{@item.title}' can now be found by others."
      redirect_to root_url
    else
      redirect_to welcome_path 
    end
  end

  def show
    
  end
end
