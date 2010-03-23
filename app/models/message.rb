class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :recipient, :class_name => "Person"
  belongs_to :author, :class_name => "Person"
  belongs_to :request
  belongs_to :reply, :class_name => "Message"
  belongs_to :accepted_item, :class_name => "Item"

  validates_presence_of :author_id, :recipient_id, :title

  named_scope :unread, :conditions => { :read => 0 }
  named_scope :unreplied, :conditions => [ "request_id > 0", { :reply_id => nil }]  
  
  def unread?
    !self.read?
  end

end
