# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def header_box
    render :partial => 'shared/avatar_header' if logged_in?
    render :partial => 'shared/login_box' unless logged_in?
  end
  
  def javascripts
    render :partial => 'shared/javascripts'
  end

  def ie_sensitivity
    render :partial => 'shared/ie_sensitivity'
  end
    
  def link_to_person(person)
    link_to(person.username, person_path(person))
  end
  
end
