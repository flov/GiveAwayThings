class Person

  validates_associated      :address, :items  
   
  validates_presence_of     :address
  
  validates_presence_of     :username
  validates_uniqueness_of   :username, :email, :allow_blank => true
  validates_format_of       :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"

  validates_format_of       :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  validates_presence_of     :password, :on => :create
  validates_confirmation_of :password
  validates_length_of       :password, :minimum => 4, :allow_blank => true

end