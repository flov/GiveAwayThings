class Address < ActiveRecord::Base
  
  has_one :person
  belongs_to :city
  accepts_nested_attributes_for :city
  
  has_many :items
  
  validates_presence_of :street
  validates_associated :city, :on => :create
  
  #concerned_with :validation
    
end

