class PeopleController < ApplicationController
  
  before_filter :find_person, :only => [ :show, :edit, :confirm_email, :unconfirmed_email, :leave_reference ]
  before_filter :login_required, :confirmed_user?, :only => [ :requests ]

  def intro

    @newsletter = Newsletter.new
    @item = Item.new(:title => 'Type in item.', :description => 'Description (optional)')
  end

  def welcome
    logged_in? ? @person=current_person : @person=Person.new
    @item = Item.new(:title => 'Type in item.', :description => 'Description (optional)')

    #@countries = Item.all.collect{|p| p.country}.uniq
    @newsletter = Newsletter.new
    if logged_in?
      @person ||= current_person
    else
      @person ||= Person.new
    end
  end

  def leave_reference
    @reference = Reference.find_by_to_id(@person.id)
    @reference ||= Reference.new
  end
  
  def create_reference
    @reference = Reference.new(params[:reference])  
  end
  
  def requests
    @requests_from_x           = current_person.requests_from_x
    @requests_by_you           = current_person.requests_from_you
    @requests_accepted_by_x    = current_person.requests_x_accepted
    @requests_you_accepted     = current_person.requests_you_accepted
  end
  
  def edit_reference
    @reference
  end
  
  def edit
    
  end
  
  def update
    @person = Person.find_by_username(params[:id])
    if @person.update_attributes(params[:person])
      flash[:notice] = t('people.update.updated')
      redirect_to @person
    else
      render :action => 'edit'
    end
  end

  def show
    @given_items   = @person.given_items
    @taken_items   = @person.taken_items
    @offered_items = @person.offered_items

    @references = @person.references

    if logged_in? && current_person == @person
      @requests_from_x           = @person.requests_from_x
      @requests_by_you           = @person.requests_from_you
      @requests_accepted_by_x    = @person.requests_x_accepted
      @requests_you_accepted     = @person.requests_you_accepted
    end
  end

  def new
    @person = Person.new
    @person.build_address
    @country = ""
    @city = ""
    l = Localize.country(request.remote_ip)
    if l
      @city = l[7]
      @country = l[4]
      @person.address.continent = l[5]
      @person.address.lat = l[9]
      @person.address.lng = l[10]
    end
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice]      = t('people.create.signed_up')
      redirect_to root_url
    else
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
      redirect_to '/'
    else
      flash[:error] = t('people.activation.invalid')
      redirect_to unconfirmed_email_person_path(@person)
    end

  end
  
  def unconfirmed_email
    if params[:resend] == @person.password_hash
      @person.send_activation_email
      flash[:notice] = t('people.activation.resent')
    end
  end

  def settings
    
  end
  
  private
    
  def find_person
    unless @person = Person.find_by_username(params[:id])
      flash[:error] = "This person does not exist"
      redirect_to '/'
    end
  end
end