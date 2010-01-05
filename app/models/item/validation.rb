class Item
  validates_presence_of :title, :person
  validates_associated :person
  
end