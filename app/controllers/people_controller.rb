class PeopleController < ApplicationController
  
  before_filter :find_person, :only => [ :show, :confirm_email ]
  before_filter :login_required, :confirmed_user?, :only => [ :show ]

  def welcome
    @item=Item.new(:title => 'Type in item.', :description => 'Description (optional)')
    @item.build_category
    @search=Item.search(params[:search])
    @items=@search.all
    @countries = Item.all.collect{|p| p.country}.uniq
    @newsletter = Newsletter.new
    if logged_in?
      @person = current_person
      @items_given                   = @person.items.taken_by_does_not_equal(0)
      @items_taken                   = @person.items_taken
      @items_offered                 = @person.items.accepted_equals(0)
    else
      @items_offered = @items_taken = @items_given = 0
      @person= Person.new
    end
  end
  
  def show
    @items_given                   = @person.items.taken_by_does_not_equal(0)
    @items_taken                   = @person.items_taken
    @requests_not_accepted         = @person.requests.item_accepted_equals(0)
    @requests_accepted             = @person.requests.item_accepted_does_not_equal(0)
    @items_offered                 = @person.items.accepted_equals(0)
    @items_offered_and_accepted    = @person.items.accepted_does_not_equal(0)
  end

  def new
    @person = Person.new
    @person.build_address.build_city.build_country
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice]      = 'Thank you for signing up! Please check your emails,'
      redirect_to root_url
    else
      flash[:error] = 'Please fill in the neccessary fields.'
      render :new
      flash.discard
    end
  end
  
  def index
    @people = Person.all
  end
  
  def confirm_email
    if @person.is_login_token_valid? params[:token]
      if @person.is_active?
        flash[:notice] = "You had already confirmed your email! You can now use GiveAwayThings."
      else
        @person.activate!
        @person.expire_login_code!
        session[:person_id] = @person.id
        flash[:notice] = "<h2>Your account has been activated!</h2>You are now loged in.<br/>Welcome to GiveAwayThings :)"
      end
    else
      flash[:error] = t('people.activation.invalid')
    end
    redirect_to '/'
  end
  
  def unconfirmed_email
    
  end
  
  private
    def find_person
      unless @person = Person.find_by_username(params[:id])
        flash[:error] = "This person does not exist"
        redirect_to '/'
      end
    end
  
end

