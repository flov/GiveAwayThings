class Person < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment

  attr_accessible :username, :email, :password, :password_confirmation, :items, :address_attributes

  concerned_with  :validation

  belongs_to :address, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :requests, :dependent => :destroy
  accepts_nested_attributes_for :address, :items

  attr_accessor :password
  before_save :prepare_password

  # login can be either username or email address
  def self.authenticate(login, pass)
    person = find_by_username(login) || find_by_email(login)
    return person if person && person.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
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
