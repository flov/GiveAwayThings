module MessagesHelper
  def message_title(message)
    if message.read?
      link_to h(message.title), message_path(message) 
    else
      link_to h(message.title), message_path(message), :class => 'bold'
    end
  end
end
