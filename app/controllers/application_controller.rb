# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def confirmed_user?
    if current_person and not current_person.is_active?
      flash[:error] = "You need to activate your account first"
      redirect_to unconfirmed_email_person_path(current_person.username)
    end
  end
  
  def given_taken_offering(person)
    @items_given       = person.items.taken_by_does_not_equal(0)
    @items_taken       = person.items_taken
    @items_offering    = person.items.accepted_id_nil
  end
end
