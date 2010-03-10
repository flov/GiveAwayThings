class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :recipient, :class_name => "Person"
  belongs_to :author, :class_name => "Person"
  belongs_to :request
  
  def unread?
    !self.read?
  end
  
  def unread_number
    self.read_equals(0).size
  end
end
