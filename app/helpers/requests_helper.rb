module RequestsHelper
  def accept_decline(request)
   "#{link_to 'Accept', accept_request_path(request)} | #{link_to 'Decline', decline_request_path(request)}"
  end
  
  def you_or_person(username)
    if current_person.username == params[:id]
      "You" 
    else
      username
    end
  end
end
