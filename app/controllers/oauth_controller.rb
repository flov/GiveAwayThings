class OauthController < ApplicationController

  # Starts the redirect authorization for OAuth
  def start
    @provider = params[:provider]
    url = client.web_server.authorize_url(
      :redirect_uri => oauth_callback_url,
      :scope => 'email,offline_access,user_about_me,user_hometown,user_location')

    redirect_to url
  end

  # Returns the user from the OAuth provider
  def callback
    
    @provider = params[:provider]
    begin
      @access_token = client.web_server.get_access_token(params[:code], :redirect_uri => oauth_callback_url)
      load_profile(@access_token)

      if logged_in?
        if current_person.app_links.find_by_provider(@provider)
          flash[:notice] = t(:'oauth.already_linked_to_your_account')
        elsif AppLink.find_by_provider_and_app_user_id(@provider, @profile[:id])
          flash[:error] = t(:'oauth.already_taken_by_other_account')
        else
          current_person.link_to_app(@provider, @profile)
          flash[:notice] = t(:'oauth.account_linked')
        end
        redirect_to(person_path(current_person))
      else
        if oauth_login
          # logged in with facebook account
          return redirect_to person_path(current_person)
        elsif Person.find_by_email(@profile[:email])
          # no Facebook account created yet
          # TODO: locate existing user by email link him
          flash[:notice] = "You already have a GiveAwayThings account.<br/>Please log in with your email address (#{@profile[:email]})."
        else
          # create Person:
          oauth_signup
        end
      end
      redirect_to root_path
    rescue OAuth2::HTTPError
      render :text => %(<p>OAuth Error ?code=#{params[:code]}:</p><p>#{$!}</p><p><a href="/auth/#{@provider}">Retry</a></p>)
    end
  end

  private
    # TODO: This will cause duplicate username and email problems
    # This should, instead, be a redirect to signup that doesn't require email
    # confirmation and that links to the OAuth account. This could be kept on session
    # TODO: Add 'source' field to users to track where they signed up from
    def oauth_signup

      new_user = Person.create! do |u|
        u.app_links.build do |a|
          a.provider = @provider
          a.app_user_id = @profile[:id]
          a.custom_attributes = @profile[:custom_attributes]
        end
        u.build_address(:street => '')
        
        u.first_name  = @profile[:first_name]
        u.last_name   = @profile[:last_name]
        u.username    = @profile[:username] || (@profile[:first_name] + "_" + ActiveSupport::SecureRandom.random_number(1000).to_s)
        u.email       = @profile[:email]
        u.password    = u.password_confirmation = ActiveSupport::SecureRandom.hex(20)
        
        u.localize(remote.ip)
      end
      
      new_user.activate!
      session[:person_id] = new_user.id
    end

    # Logs in with the chosen provider, if the AppLink exists
    def oauth_login
      person = AppLink.find_by_provider_and_app_user_id(@provider, @profile[:id]).try(:person)
      session[:person_id] = person.id unless person.nil?
    end

    # Prepares a OAuth client
    def client
      @config = APP_CONFIG['oauth_providers'][@provider]
      raise "Provider #{@provider} is missing. Please add the key and secret to the configuration file." unless @config
      @client ||= OAuth2::Client.new(
        @config['client_id'],
        @config['secret_key'],
        :site => @config['site'],
        :authorize_path => @config['authorize_path'],
        :access_token_path => @config['access_token_path'])
    end

    # Loads user's OAuth profile in @profile
    def load_profile(access_token)
      user = JSON.parse(access_token.get(@config['user_path']))
      # user = {"name"=>"Florian Vallen", "timezone"=>2, "id"=>"1011496368", "last_name"=>"Vallen", "updated_time"=>"2010-06-02T09:00:13+0000", "verified"=>true, "link"=>"http://www.facebook.com/fvallen", "email"=>"florian.vallen@gmail.com", "first_name"=>"Florian"}
      @profile = {}
      case @provider
      # when "github"
      #   user = user['user']
      #   @profile[:id]         = user['id']
      #   @profile[:email]      = user['email']
      #   @profile[:username]   = user['login']
      #   @profile[:first_name] = user['name'].split.first
      #   @profile[:last_name]  = user['name'].split.second
      #   @profile[:company]    = user['company']
      #   @profile[:location]   = user['location']
      #   @profile[:custom_attributes] = user
      when "facebook"
        @profile[:id]                = user['id']
        @profile[:facebook_link]     = user['link']
        @profile[:email]             = user['email']
        @profile[:first_name]        = user['first_name']
        @profile[:last_name]         = user['last_name']
        @profile[:confirmed_user]    = user['verified']
        unless user['link'].include?('?')
          # "link"=>"http://www.facebook.com/fvallen" if username is set
          # "link"=>"http://www.facebook.com/profile.php?id=100001281430052" if username is not set
          @profile[:username]        = user['link'].split('/').last   
        end
        @profile[:custom_attributes] = user
      else
        raise "Unsupported provider: '#{@provider}'"
      end
      @profile[:username] = Person.find_available_username(@profile[:username])
    end
end
