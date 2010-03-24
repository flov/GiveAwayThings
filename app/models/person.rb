class Person < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment

  attr_accessible :username, :email, :password, :password_confirmation, :items_attributes, :address_attributes

  concerned_with  :validation,
                  :activation

  belongs_to :address, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :items_taken, :class_name => "Item", :foreign_key => "taken_by"
  has_many :requests, :dependent => :destroy, :foreign_key => "owner_id"
  has_many :requested_items, :class_name => 'Request', :foreign_key => "requester_id"
  has_many :messages, :foreign_key => "recipient_id"
  has_many :references, :foreign_key => "to_id"
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :items
  

  attr_accessor :password
  before_save :prepare_password

  def offered_items
    self.items.requests_accepted_equals false
  end
  
  def given_items
    self.items.taken_by_gt(0)
  end
  
  def taken_items
    self.requested_items.item_taken_by_gt(0)
  end
  
  def accepted_requests
    self.requested_items.accepted_equals(true)
  end
  
  def requests_you_accepted
    self.requests.accepted_equals(true)
  end

  def unaccepted_requests
    self.requests.accepted_equals(false)
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

  # login can be either username or email address
  def self.authenticate(login, pass)
    person = find_by_username(login) || find_by_email(login)
    if person && person.matching_password?(pass)
      return person 
    end
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
  
  def to_s
    self.username
  end

  def to_param
    self.username
  end
  
  def after_create
    send_activation_email unless self.confirmed_user
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end

end