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
    @current_person ||= login_from_session
  end
  
  def login_from_session
    Person.find(session[:person_id]) if session[:person_id]
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
