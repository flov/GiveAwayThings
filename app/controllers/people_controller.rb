class PeopleController < ApplicationController
  
  before_filter :find_person, :only => [ :show, :confirm_email, :unconfirmed_email ]
  before_filter :login_required, :confirmed_user?, :only => [ :show ]


  def welcome
    logged_in? ? @person=current_person : @person=Person.new
    @item = Item.new(:title => 'Type in item.', :description => 'Description (optional)')
    @item.build_category

    
    @countries = Item.all.collect{|p| p.country}.uniq
    @newsletter = Newsletter.new
    if logged_in?
      @person ||= current_person
    else
      @person ||= Person.new
    end
  end
  
  def requests
    @undecided_requests        = current_person.unaccepted_requests
    @requests_accepted_by_x    = current_person.accepted_requests
    @requests_accepted_by_you  = current_person.requests_you_accepted
    @requests_by_you           = current_person.requests.accepted_equals false
  end
  
  def show
    
    @given_items   = @person.given_items
    @taken_items   = @person.taken_items
    @offered_items = @person.offered_items
    
    @undecided_requests = @person.unaccepted_requests
    @accepted_requests  = @person.accepted_requests
    @requests_you_accepted  = @person.requests_you_accepted
    @references = @person.references
  end

  def new
    @person = Person.new
    @person.build_address.build_city.build_country
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice]      = t('people.create.signed_up')
      redirect_to root_url
    else
      flash[:error] = t('people.create.validation')
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

