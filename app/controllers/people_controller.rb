class PeopleController < ApplicationController
  def index
    @item = Item.new
  end

  def new
    @person = Person.new
    @person.addresses.build
  end
  
  def create
    @person = Person.new(params[:person])
    if @person.save
      session[:person_id] = @person.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      @person.addresses.build
      render :new
    end
  end


end
