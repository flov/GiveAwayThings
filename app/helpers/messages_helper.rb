module MessagesHelper
  def message_title(message)
    if message.read?
      link_to h(message.title), message_path(message) 
    else
      link_to h(message.title), message_path(message), :class => 'bold'
    end
  end
  
  def reply_message(message)
    if message.replied_at.nil?
      link_to 'reply', reply_message_path(message)
    else
      message.replied_at.strftime("%d/%m/%Y<br/>%k:%M")
    end
  end

  def accept_request_link(message)
    if not message.request.nil? # if the message comes from a request
      if message.request.accepted == false # if the request the message points to is not yet accepted
        link_to 'Accept', accept_request_path(message.request) 
      else
        "<i>Accepted</i>"
      end
    end
  end
  
  def print_item(request)
    link_to(truncate(request.item.title, 48), item_path(request.item.to_param))
  end
  
  def item_with_date(request)
    "<span class='date'>" + 
      request.updated_at.strftime("%d/%m/%Y %k:%M") +
    "</span>" +
    link_to(request.item.title, item_path(request.item.to_param))

  end
  
  def time_output(message)
    message.created_at.strftime("%d.%b") 
  end
  
  def subject(message)
    unless message.request.nil?
      link_to '<div class=request_flag></div>', item_path(message.request.item)
    end
    message_title(message)
  end
end