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
      message.replied_at.strftime("%d/%m/%Y %M:%H")
    end
  end
end
