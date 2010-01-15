class PeopleController < ApplicationController
  def welcome
    @item = Item.new
    @countries = Item.all.collect{|p| p.address}.uniq.collect{|p| p.city}.uniq.collect{|p| p.country}.uniq.collect{|p| p.name}
  end

  def new
    @person = Person.new
    @person.build_address.build_city
  end

  def create
    @person               = Person.new(params[:person])
    if @person.save
      session[:person_id] = @person.id
      flash[:notice]      = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :new
    end
  end
end

