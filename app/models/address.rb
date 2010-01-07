class Address < ActiveRecord::Base

  belongs_to :person
  has_many :items

  concerned_with :validation
  
end
