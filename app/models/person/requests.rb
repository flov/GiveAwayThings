class Person
  def requests_x_accepted
    self.requested_items.accepted_equals(true)
  end
  
  def requests_you_accepted
    self.requests.accepted_equals(true)
  end

  def requests_from_x
    self.requests.accepted_equals(false)
  end
  
  def requests_from_you
    self.requested_items.accepted_equals(false)
  end
end