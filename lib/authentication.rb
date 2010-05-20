# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
# 
#   <% if logged_in? %>
#     Welcome <%=h current_person.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
# 
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
# 
#   before_filter :login_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_person, :logged_in?, :redirect_to_target_or_default
    controller.filter_parameter_logging :password
  end
  
  def current_person
    @current_person ||= (login_from_session || login_from_fb)
  end
  
  def login_from_session
    Person.find(session[:person_id]) if session[:person_id]
  end

  #find the user in the database, first by the facebook user id and if that fails through the email hash
  def login_from_fb
    if facebook_session
      self.current_person = Person.find_by_fb_user(facebook_session.user)
    end
  end

  def logged_in?
    current_person
  end
  
  def login_required
    unless logged_in?
      flash[:error] = t('flash.not_logged_in')
      store_target_location
      redirect_to signup_url
    end
  end
  
  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  
  private
  
  def store_target_location
    session[:return_to] = request.request_uri
  end
end
