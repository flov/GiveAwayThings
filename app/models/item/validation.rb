class Item
  validates_presence_of :title, :person, :address
  validates_associated :person
end