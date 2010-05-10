class Person

  def offered_items
    self.items.accepted_equals nil
  end
  
  def given_items
    self.items.taken_by_gt(0)
  end
  
  def taken_items
    Item.taken_by_equals(self)
  end
    
  def country
    self.address.city.country
  end
  
  def city
    self.address.city
  end
      
  def unreplied_requests
    self.messages.unreplied
  end
  
  def unread_messages
    self.messages.unread
  end

end