class Item < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :address
  belongs_to :category
  has_many :requests
  has_attached_file :photo
  
  accepts_nested_attributes_for :category
  
  concerned_with :validation

end
