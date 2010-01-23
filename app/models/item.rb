class Item < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :address
  belongs_to :category
  has_many :requests
  
  accepts_nested_attributes_for :category
  
  concerned_with :validation

end
