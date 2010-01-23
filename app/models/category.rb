class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :items
  
  def to_s
    name
  end
  
end
