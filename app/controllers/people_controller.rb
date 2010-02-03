class PeopleController < ApplicationController
  def welcome
    @item=Item.new(:title => 'Type in item.', :description => 'Description (optional)')
    @item.build_category
    @search=Item.search(params[:search])
    @items=@search.all
    @countries = Item.all.collect{|p| p.country}.uniq
    if logged_in?
      @person = current_person
      @items_given                   = @person.items.taken_by_does_not_equal 0
      @items_taken                   = @person.items_taken
      @items_offered                 = @person.items.accepted_equals 0
    else
      @items_offered = @items_taken = @items_given = 0
      @person= Person.new
    end
  end
  
  def show
    @person = Person.find_by_username(params[:id])
    @items_given                   = @person.items.taken_by_does_not_equal 0
    @items_taken                   = @person.items_taken
    @requests_not_accepted         = @person.requests.item_accepted_equals 0
    @requests_accepted             = @person.requests.item_accepted_does_not_equal 0
    @items_offered                 = @person.items.accepted_equals 0
    @items_offered_and_accepted    = @person.items.accepted_does_not_equal 0
  end

  def new
    @person = Person.new
    @person.build_address.build_city.build_country
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      #UserMailer.registration_confirmation(@person)
      session[:person_id] = @person.id
      flash[:notice]      = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :new
    end
  end
  
  def index
    @people = Person.all
  end
end

