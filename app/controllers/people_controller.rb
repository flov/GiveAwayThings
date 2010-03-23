class PeopleController < ApplicationController
  
  before_filter :find_person, :only => [ :show, :confirm_email, :unconfirmed_email ]
  before_filter :login_required, :confirmed_user?, :only => [ :show ]


  def welcome
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
  
  def show

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
    else
      flash[:error] = t('people.activation.invalid')
    end
    redirect_to '/'
  end
  
  def unconfirmed_email
    if params[:resend] == @person.password_hash
      @person.send_activation_email
      flash[:notice] = t('people.activation.resent')
    end
  end
  
  private
    
  def find_person
    unless @person = Person.find_by_username(params[:id])
      flash[:error] = "This person does not exist"
      redirect_to '/'
    end
  end
end

