class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :recipient, :class_name => "Person"
  belongs_to :author, :class_name => "Person"
  belongs_to :request
  belongs_to :reply, :class_name => "Message"

  validates_presence_of :author_id, :recipient_id, :title
  
  def unread?
    !self.read?
  end
  
end
