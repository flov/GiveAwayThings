class PeopleController < ApplicationController
  def index
    redirect_to root_path unless logged_in?
    @item = Item.new
  end

  def new
    @person = Person.new
  end
  
  def create

    raise 'error'
    @person = Person.new(params[:person])
    if @person.save
      session[:person_id] = @person.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end


end
