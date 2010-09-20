module RequestsHelper
  def accept_decline(request)
   "#{link_to 'Accept', accept_request_path(request)} | #{link_to 'Decline', decline_request_path(request)}"
  end

  def you_or_person(person)
    if logged_in? and current_person.username == params[:id]
      "You" 
    else
      person.username.capitalize
    end
  end
  
  def you_or_person_offer(person)
    if logged_in? and current_person.username == params[:id]
      "You Offer" 
    else
      "#{person.username.capitalize} Offers"
    end
  end
end
