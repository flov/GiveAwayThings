class Address < ActiveRecord::Base

  belongs_to :person
  belongs_to :item

  concerned_with :validation
  
end
