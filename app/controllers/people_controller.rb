class PeopleController < ApplicationController
  def welcome
    @item = Item.new
    @countries = Country.all.collect{|p| [p.to_s]}
  end

  def new
    @person = Person.new
    @person.build_address.build_city.build_country
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

