class Person < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment

  attr_accessible :username, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :items_attributes, 
                  :address_attributes, 
                  :biography,
                  :full_name,
                  :name

  concerned_with  :validation,
                  :activation,
                  :requests,
                  :attributes,
                  :oauth

  belongs_to :address, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :items_taken, :class_name => "Item", :foreign_key => "taken_by"
  has_many :requests, :dependent => :destroy, :foreign_key => "owner_id"
  has_many :requested_items, :class_name => 'Request', :foreign_key => "requester_id"
  has_many :messages, :foreign_key => "recipient_id"
  has_many :references, :foreign_key => "to_id"
  has_many :app_links
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :items

  after_create :send_activation_email  

  attr_accessor :password
  before_save :prepare_password

  def full_name=(name)
    split = name.split(' ')
    self.first_name = split.first
    self.last_name  = split.last
  end
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
  def link_to_app(provider, profile)
    link = AppLink.new
    link.user              = self
    link.provider          = provider
    link.app_user_id       = profile[:id]
    link.custom_attributes = profile[:original]
    link.save!
  end
  
  
  def has_opened_requests?
    not self.requests.unarchived.empty? or not self.requested_items.unarchived.empty?
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