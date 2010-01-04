class Item
  validates_presence_of :name
  validates_uniqueness_of :name    
end